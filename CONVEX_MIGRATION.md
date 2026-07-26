# Migrating Watt's backend to Convex (keeping Firebase Auth)

This moves your **data + storage** from Firestore/Firebase Storage to **Convex**,
while **Firebase Auth stays exactly as it is**. Convex simply validates the
Firebase ID token your app already issues.

```
Flutter app ──(email/password)──▶ Firebase Auth  ✅ unchanged
     │
     │  Firebase ID token (JWT)
     ▼
  Convex  ── validates token as a custom OIDC provider ──▶ data + files
```

Everything is already scaffolded in this repo:

| Piece | Location |
|-------|----------|
| Schema | `convex/schema.ts` |
| Auth config (Firebase) | `convex/auth.config.ts` |
| Functions | `convex/users.ts`, `convex/friends.ts`, `convex/wagers.ts`, `convex/files.ts` |
| Flutter client wrapper | `lib/services/convex_service.dart` |
| Deployment URL config | `lib/config/convex_config.dart` |
| Client init | wired in `lib/main.dart` (no-op until configured) |

---

## Step 1 — Install the Convex CLI and log in

You need **Node.js 18+** installed. From the project root:

```bash
npm install                 # installs the `convex` dev dependency (package.json)
npx convex dev              # first run: opens a browser to create/login + link a project
```

`npx convex dev` watches the `convex/` folder and pushes `schema.ts` + all
functions to your **dev deployment**. Leave it running while you work. On first
run it prints (and writes to `.env.local`) your deployment URL, e.g.

```
https://blessed-otter-123.convex.cloud
```

## Step 2 — Confirm Firebase auth is accepted

`convex/auth.config.ts` is already set to your project:

```ts
domain: "https://securetoken.google.com/wager-app-34c29",
applicationID: "wager-app-34c29",
```

`npx convex dev` pushes this automatically. To sanity-check the values, sign in
on the app, grab a token (`FirebaseAuth.instance.currentUser!.getIdToken()`),
paste it into https://jwt.io and confirm `iss` and `aud` match the two lines above.

## Step 3 — Point the app at your deployment

Either paste the URL into `lib/config/convex_config.dart` (`defaultValue`), or
pass it at run/build time (preferred, keeps it out of git):

```bash
flutter run --dart-define=CONVEX_URL=https://blessed-otter-123.convex.cloud
```

Until this is set, Convex stays disabled and the app runs exactly as today.

## Step 4 — Bridge Firebase Auth → Convex

Call `bindFirebaseAuth()` after a successful sign-in and on startup if already
signed in; call `signOut()` when logging out.

```dart
// After login/register succeeds:
await ConvexService.instance.bindFirebaseAuth();

// In your logout flow (profile_viewmodel.dart), alongside FirebaseAuth.signOut():
await ConvexService.instance.signOut();
```

A good place for startup is right after `init()` in `main.dart` if
`FirebaseAuth.instance.currentUser != null`.

---

## Step 5 — Cut screens over one at a time

The wrapper decodes Convex's JSON for you. Functions are named `"file:function"`.

### Register — create the profile row
`register_view_model.dart`, replace `_createUserDocument(...)` Firestore write:

```dart
// after createUserWithEmailAndPassword succeeds:
await ConvexService.instance.bindFirebaseAuth();
await ConvexService.instance.mutation('users:createProfile', {
  'username': userNameController.text.trim(),
  'firstName': firstNameController.text.trim(),
});
```

### Home / Profile — load the current user
Replace the `FirebaseFirestore...doc(uid).get()` in `home_viewmodel.dart` /
`profile_viewmodel.dart`:

```dart
final user = await ConvexService.instance.query('users:currentUser');
userData = user == null ? null : Map<String, dynamic>.from(user);
notifyListeners();
```

### Friends list (live) — `add_friends_view_model.dart`
Replace `getFriendsStream()` (which returned a Firestore `Stream<QuerySnapshot>`)
with a Convex subscription. Simplest approach: expose a `ValueNotifier` /
`List` the view listens to.

```dart
final List<Map<String, dynamic>> friends = [];
SubscriptionHandle? _friendsSub;

Future<void> watchFriends() async {
  _friendsSub = await ConvexService.instance.subscribe(
    'friends:myFriends', {}, (data) {
      friends
        ..clear()
        ..addAll(List<Map<String, dynamic>>.from(data ?? []));
      notifyListeners();
    });
}

@override
void dispose() { _friendsSub?.cancel(); super.dispose(); }
```

Add a friend:
```dart
await ConvexService.instance.mutation('friends:sendRequest',
    {'toUsername': userNameController.text.trim()});
```

> In the UI, `friendUsername` replaces the old `username` field. Update the
> `AddFriendsView` list to read from `friends` instead of a `StreamBuilder`.

### Notifications (live) — `inbox_view_model.dart`
```dart
// subscribe to pending requests:
await ConvexService.instance.subscribe('friends:myRequests', {}, (data) { ... });

// respond (note: requestId is now the Convex document _id string):
await ConvexService.instance.mutation('friends:respondToRequest',
    {'requestId': requestId, 'action': 'accept'}); // or 'reject'
```

The old dual-path (`respondToFriendRequest` / `...ByUsername`) collapses into
this one call — accept/reject is fully handled server-side in `friends.ts`.

### Wagers — `wager_view_model.dart` (currently in-memory sample data)
```dart
await ConvexService.instance.subscribe('wagers:myWagers', {}, (data) {
  wagerList = List<Map<String,dynamic>>.from(data ?? [])
      .map(Wager.fromConvex).toList(); // add a Wager.fromConvex factory
  _applyFilters();
});

await ConvexService.instance.mutation('wagers:createWager', {
  'title': ..., 'description': ..., 'player1': ..., 'player2': ...,
  'stake': ..., 'status': 'pending', 'date': ...,
});
```

### Profile photo (Convex Storage, replaces Firebase Storage)
```dart
// 1) pick a file with image_picker, read bytes
final uploadUrl = await ConvexService.instance.mutation('files:generateUploadUrl');
// 2) PUT the bytes to uploadUrl (use package:http), read {storageId} from the response
// 3) attach it:
await ConvexService.instance.mutation('files:saveProfilePhoto', {'storageId': storageId});
// 4) display it:
final url = await ConvexService.instance.query('files:myProfilePhotoUrl');
```

---

## Step 6 — Migrate existing data (only the real Firestore data)

Wagers were sample data and profile photos didn't exist yet, so the **only real
data** is `Users`, `friends`, and pending requests. Options:

- **Simplest:** users re-register / re-send friend requests (small user base).
- **Scripted:** export Firestore (`gcloud firestore export` or the console) and
  write a one-off Convex `internalMutation` seeded from the JSON. Note your old
  data mixes **email** and **uid** as keys — normalise everything to Firebase
  **uid** (what `identity.subject` gives) as you import.

## Step 7 — Decommission Firebase data services

Once every screen above reads/writes Convex and you've verified it live:

1. Remove `cloud_firestore` usage, then the dependency from `pubspec.yaml`.
2. Delete the `FirebaseFirestore.instance.settings` line in `main.dart`.
3. Keep `firebase_auth` + `firebase_core` (still used for auth).

---

## Production deploy

```bash
npx convex deploy            # pushes to your prod deployment
```

Use the **prod** deployment URL for release builds
(`--dart-define=CONVEX_URL=...`). Convex dev and prod are separate deployments
with separate data.
