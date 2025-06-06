import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signup(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success) {
      throw FirebaseAuthException(
        code: 'ERROR_FACEBOOK_LOGIN_FAILED',
        message: loginResult.message,
      );
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    final currentUser = FirebaseAuth.instance.currentUser;

    // Link if already signed in
    if (currentUser != null) {
      try {
        await currentUser.linkWithCredential(facebookAuthCredential);
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          // Already linked, sign in
          return await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
        } else if (e.code == 'credential-already-in-use') {
          // Another account already uses this credential. Sign in directly.
          return await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
        } else {
          rethrow;
        }
      }
    } else {
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    }
  }

  Future<bool> loginWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      await auth.signInWithPopup(googleProvider);
      return true;
    } else {
      try {
        GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
        await googleSignIn.signOut();
        GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        if (googleUser == null) {
          debugPrint("User cancelled the sign-in");
          return false;
        }

        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final currentUser = FirebaseAuth.instance.currentUser;

        // Link if already signed in
        if (currentUser != null) {
          try {
            await currentUser.linkWithCredential(googleCredential);
            await FirebaseAuth.instance.signInWithCredential(googleCredential);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'provider-already-linked') {
              await FirebaseAuth.instance
                  .signInWithCredential(googleCredential);
            } else if (e.code == 'credential-already-in-use') {
              await FirebaseAuth.instance
                  .signInWithCredential(googleCredential);
            } else {
              rethrow;
            }
          }
        } else {
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
        }

        return true;
      } catch (e) {
        debugPrint("Google Sign-In error: $e");
        return false;
      }
    }
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  // Future<bool> loginWithGoogle() async {
  //   if (kIsWeb) {
  //     GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //     await auth.signInWithPopup(googleProvider);
  //     return true;
  //   } else {
  //     try {
  //       GoogleSignIn googleSignIn = GoogleSignIn(
  //         scopes: ['email'],
  //       );

  //       await googleSignIn.signOut();

  //       GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //       if (googleUser == null) {
  //         debugPrint("User cancelled the sign-in");
  //         return false;
  //       }

  //       GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //       AuthCredential myCredential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       await FirebaseAuth.instance.signInWithCredential(myCredential);
  //       return true;
  //     } catch (e) {
  //       debugPrint("Google Sign-In error: $e");
  //       return false;
  //     }
  //   }
  // }
}
