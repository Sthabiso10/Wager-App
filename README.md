<p align="center">
  <img src="assets/watt_logo.png" alt="Watt logo" width="120">
</p>

<h1 align="center">Watt 🎲</h1>

Watt is a cross-platform Flutter app for creating wagers with friends, tracking their status, and settling up — with real-time sync, friend requests, and notifications.

Built as a portfolio project to explore clean MVVM architecture in Flutter, a Firebase → Convex backend migration, and multi-platform delivery (mobile, web, and desktop) from a single codebase.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Auth-Firebase-FFCA28?logo=firebase&logoColor=black)
![Convex](https://img.shields.io/badge/Backend-Convex-8D2676)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Platform Support](#platform-support)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [Roadmap](#roadmap)

## Overview

Watt lets a user sign up, add friends by username, and create a wager between two people with a title, description, and stake. Wagers and friend requests update live across devices, and the app is built to run on Android, iOS, web, Windows, macOS, and Linux from one Flutter codebase.

The backend is mid-migration from Firebase (Firestore) to [Convex](https://convex.dev), while keeping Firebase Authentication as the identity provider — Convex validates the Firebase-issued JWT rather than replacing auth. See [CONVEX_MIGRATION.md](CONVEX_MIGRATION.md) for the full migration plan and current cutover status per screen.

## Features

- **Authentication** — email/password sign-up and login via Firebase Auth
- **Wagers** — create, edit, and track wagers between two players with a stake, status (pending/active/won/lost), and date
- **Friends** — send, accept, and reject friend requests by username, with a live friends list
- **Inbox** — real-time notifications for incoming friend requests
- **Profile** — profile photos via image picker (camera or gallery)
- **Scheduled reminders** — time-zone aware local notifications
- **Swipe actions & FAB** — `flutter_slidable` list interactions and a `flutter_speed_dial` quick-create menu

## Tech Stack

**Frontend**
- [Flutter](https://flutter.dev) / Dart 3
- [Stacked](https://pub.dev/packages/stacked) — MVVM architecture (View / ViewModel separation)
- [get_it](https://pub.dev/packages/get_it) — service locator / dependency injection
- Google Fonts, Lottie, `simple_animations`, `google_nav_bar`, `flutter_speed_dial`, `flutter_slidable`

**Backend**
- [Firebase Authentication](https://firebase.google.com/docs/auth) — identity, unchanged by the Convex migration
- [Convex](https://convex.dev) — data storage, real-time subscriptions, and file storage (replacing Firestore/Firebase Storage; see [`convex/`](convex/))
- `flutter_dotenv` — local configuration

**Utilities**
- `image_picker`, `permission_handler`, `timezone`, `intl`, `uuid`

## Architecture

The app follows the **Stacked (MVVM)** pattern: each feature under [`lib/app/`](lib/app) has a `view` (widgets only) paired with a `view_model` (state and business logic), wired together with `get_it` for DI. This keeps UI code free of business logic and makes ViewModels straightforward to unit test.

```
Flutter app ──(email/password)──▶ Firebase Auth
     │
     │  Firebase ID token (JWT)
     ▼
  Convex ── validates token as an OIDC provider ──▶ data + file storage
```

Convex functions live in [`convex/`](convex) (`users.ts`, `friends.ts`, `wagers.ts`, `files.ts`), and the Flutter side talks to them through [`lib/services/convex_service.dart`](lib/services/convex_service.dart). Until a deployment URL is configured, Convex stays inactive and the app runs on its original Firestore path — see [CONVEX_MIGRATION.md](CONVEX_MIGRATION.md) for the screen-by-screen cutover.

> **Note for AI coding agents:** this repo's [CLAUDE.md](CLAUDE.md) / [AGENTS.md](AGENTS.md) point to `convex/_generated/ai/guidelines.md` for Convex-specific conventions — read that before editing anything under `convex/`.

## Platform Support

| Platform | Status |
|----------|--------|
| Android  | ✅ |
| iOS      | ✅ |
| Web      | ✅ |
| Windows  | ✅ |
| macOS    | ✅ |
| Linux    | ✅ |

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.0+ (Dart 3.0+)
- A [Firebase](https://console.firebase.google.com) project (Authentication enabled)
- [Node.js](https://nodejs.org) 18+ (for the Convex CLI)
- Git

### 1. Clone and install dependencies

```bash
git clone https://github.com/Sthabiso10/Wager-App.git
cd Wager-App
flutter pub get
npm install
```

### 2. Configure Firebase

This app uses [FlutterFire](https://firebase.flutter.dev/docs/cli) to generate platform config. If you're setting up your own Firebase project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates `lib/firebase_options.dart`, which is gitignored — each developer/environment generates their own.

### 3. Configure Convex (optional — the app runs without it)

```bash
npx convex dev
```

This links a Convex deployment and pushes `convex/schema.ts` and the functions to it, printing a deployment URL (`https://<name>.convex.cloud`). Point the app at it via `--dart-define`:

```bash
flutter run --dart-define=CONVEX_URL=https://<your-deployment>.convex.cloud
```

Leaving `CONVEX_URL` unset keeps Convex disabled with no behavior change — see [`lib/config/convex_config.dart`](lib/config/convex_config.dart). Full migration/cutover details live in [CONVEX_MIGRATION.md](CONVEX_MIGRATION.md).

### 4. Run the app

```bash
flutter run
```

### 5. Run tests

```bash
flutter test
```

## Project Structure

```
lib/
├── app/                  # Feature modules (Stacked MVVM: view + view_model per feature)
│   ├── login/, register/ # Auth screens
│   ├── home/             # Home feed
│   ├── wagers/           # Wager creation, list, and detail
│   ├── add_friends/      # Friend search & requests
│   ├── inbox/            # Notifications / pending requests
│   ├── profie/           # Profile & settings
│   └── navigation bar/   # Bottom nav shell
├── auth/                 # Firebase Auth helpers
├── config/               # Runtime configuration (e.g. Convex deployment URL)
├── models/                # Data models
├── providers/             # App-level providers
├── services/              # Convex client, notifications, etc.
├── styles/                # Design tokens (theme, colors, typography)
└── main.dart

convex/                   # Convex schema, functions, and auth config
```

## Contributing

Contributions are welcome — this is an actively evolving project.

1. Fork the repo and create a branch: `git checkout -b feature/your-feature`
2. Make your changes, following the existing Stacked view/view_model pattern for new screens
3. Run `flutter analyze` and `flutter test` before opening a PR
4. Open a pull request describing what changed and why

If you're touching anything under `convex/`, read [`convex/_generated/ai/guidelines.md`](convex/_generated/ai/guidelines.md) first — it documents current Convex conventions for this repo.

## Roadmap

- [ ] Complete the Firestore → Convex cutover for all screens (see [CONVEX_MIGRATION.md](CONVEX_MIGRATION.md))
- [ ] Migrate profile photo storage from Firebase Storage to Convex file storage
- [ ] Decommission `cloud_firestore` once Convex is fully live

## License

MIT — see [LICENSE](LICENSE).
