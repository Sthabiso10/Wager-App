// Convex accepts your existing Firebase Auth ID tokens as a custom OIDC
// provider. The `domain` must equal the `iss` claim of a Firebase ID token and
// `applicationID` must equal the `aud` claim — both are your Firebase project id.
//
// (Verify by pasting a fresh ID token into https://jwt.io and checking iss/aud.)
export default {
  providers: [
    {
      domain: "https://securetoken.google.com/wager-app-34c29",
      applicationID: "wager-app-34c29",
    },
  ],
};
