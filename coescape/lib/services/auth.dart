import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_handler.dart';
import '../utils/constants.dart';
import 'databases.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  UserHandler _userFromFirebaseUser(User? user) => UserHandler(
        uid: user!.uid,
        email: user.email!,
      );

  User? get currentUsr => _auth.currentUser;

  Stream<UserHandler> get user =>
      _auth.authStateChanges().map(_userFromFirebaseUser);

  // * This function is responsible for signing in a user with their email and password.
  // * It takes in the user's email and password as parameters.
  // * It attempts to sign in the user using the provided email and password.
  // * If successful, it returns the user as a UserHandler object; otherwise, it returns null.
  // * This function is used in the sign in screen.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      return null;
    }
  }
/* 
  // * This function is responsible for signing in a user using Google authentication provider.
  // * It signs the user out from Google, then prompts the user to sign in with their Google account.
  // * If the user is not signed in or their email does not end with "@hns-re2sd.dz", it throws an exception with the message "not-hns".
  // * It then uses the Google authentication credentials to sign in the user and returns the user as a UserHandler object.
  // * This function is used in the sign in screen.
  Future signInWithGoogleProvider() async {
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("no-email");
    }
    if (!await DatabaseService().isUserRegistered(googleUser.email)) {
      throw Exception("not-registered");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  // * This function is responsible for signing up a user using Google authentication provider.
  // * It takes in the user's userType, grade, and speciality as parameters.
  // * If the user is not signed in with an email ending with "@hns-re2sd.dz",
  // * it will throw an exception with the message "not-hns".
  // * It then uses the Google authentication credentials to sign in the user and update the user data in the database.
  // * If the userType is 'teacher', it updates the teacher data; otherwise, it updates the student data and modules with criteria.
  // * Finally, it returns the user from the Firebase user.

  Future signUpWithGoogleProvider() async {
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInUser = await googleSignIn.signIn();
    if (googleSignInUser == null) {
      throw Exception("no-email");
    }
    final GoogleSignInAuthentication googleAuth =
        await googleSignInUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    String username = capitalizeWords(user!.displayName) ?? "Username";
    await DatabaseService(uid: user.uid).updateUserData(
      uid: user.uid,
      googleId: googleSignInUser.id,
      username: username,
      email: user.email!,
      photoURL: user.photoURL!,
    );

    return _userFromFirebaseUser(user);
  } */

  // * This function is responsible for signing up a user with email and password
  // * It takes in the user's name, email, password, user type, and optional modules, grade, and speciality
  // * It creates a new user with the provided email and password, then updates the user data in the database
  // * If the user type is 'teacher', it updates the teacher data with the provided modules
  // * If the user type is 'student', it updates the student data with the provided grade and speciality, and also updates modules with criteria
  // * Finally, it returns the user from the Firebase user.
  // * This function is used in the sign up screen.

  Future signUpWithEmailAndPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      await DatabaseService().updateUserData(
        uid: user!.uid,
        googleId: null,
        username: username,
        email: user.email!,
        photoURL: user.photoURL!,
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future<UserHandler> signInWithGoogle(BuildContext context) async {
    try {
      // Logging out first
      await googleSignIn.signOut();
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('sign-in-aborted');
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the GoogleAuthProvider
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Check if the user exists in the database
      await DatabaseService().isUserRegistered(googleUser.id).then(
        (value) async {
          if (!value) {
            throw Exception('not-registered');
          }
        },
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(googleCredential);
      final User? user = userCredential.user;

      if (context.mounted) {
        // Check if the context is not null and is mounted
        showSnackBar(context, "Logged in successfully", Colors.green[900]!);
      }
      return _userFromFirebaseUser(user!);
    } catch (e) {
      throw Exception('sign-in-failed');
    }
  }

  Future<UserHandler> signUpWithGoogle(BuildContext context) async {
    try {
      // Logging out first
      await googleSignIn.signOut();
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('sign-up-aborted');
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the GoogleAuthProvider
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(googleCredential);

      // Check if the user exists in the database
      await DatabaseService().isUserRegistered(googleUser.id).then(
        (value) async {
          if (!value) {
            // If user doesn't exist, create a new user document
            final User? user = userCredential.user;

            String username = capitalizeWords(user!.displayName) ?? "Username";
            await DatabaseService().updateUserData(
              uid: user.uid,
              googleId: googleUser.id,
              username: username,
              email: user.email!,
              photoURL: user.photoURL!,
            );
            if (context.mounted) {
              // Check if the context is not null and is mounted
              showSnackBar(
                  context, "User created successfully", Colors.green[900]!);
            }
          } else {
            if (context.mounted) {
              // Check if the context is not null and is mounted
              showSnackBar(
                context,
                "User exists, logging in instead",
                Colors.green[900]!,
              );
            }
          }
        },
      );
      return _userFromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception('sign-up-failed');
    }
  }

  // * Logs the user out and displays a snackbar with the result

  Future<void> logout(BuildContext context) async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      if (context.mounted) {
        // Check if the context is not null and is mounted
        showSnackBar(context, "Logged out successfully", Colors.blue[900]!);
      }
    } catch (e) {
      if (context.mounted) {
        // Check if the context is not null and is mounted
        showSnackBar(context, e.toString(), Colors.red[900]!);
      }
    }
  }
}
