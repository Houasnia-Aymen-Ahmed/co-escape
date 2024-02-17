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

  Future signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
    required String domain,
    required String userType,
    String? activityField,
    String? marketingStrategyAndBMC,
    String? diplomaPath,
    String? cvPath,
    bool? isStartup = false,
    String? idea,
    String? ideaPresetationPath,
    int? experienceConsultant,
    int? experienceAssistant,
    bool? hasInvestor,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await DatabaseService().createUserData(
        username: username,
        uid: user!.uid,
        email: user.email!,
        domain: domain,
        photoURL: user.photoURL ?? "",
        googleId: null,
        token: null,
      );

      if (userType == 'Startup Owner') {
        if (isStartup!) {
          await DatabaseService().createStartupOwnerData(
            username: username,
            uid: user.uid,
            email: user.email!,
            domain: domain,
            photoURL: user.photoURL!,
            googleId: null,
            token: null,
            marketingStrategyAndBMC: marketingStrategyAndBMC!,
            hasInvestor: hasInvestor!,
          );
        } else {
          await DatabaseService().createStartupOwnerData(
            username: username,
            uid: user.uid,
            email: user.email!,
            domain: domain,
            photoURL: user.photoURL!,
            googleId: null,
            token: null,
            marketingStrategyAndBMC: marketingStrategyAndBMC!,
            hasInvestor: hasInvestor!,
          );
        }
      } else if (userType == 'Investor') {
        await DatabaseService().createInvestorUserData(
          username: username,
          uid: user.uid,
          usertype: userType,
          email: user.email!,
          domain: domain,
          photoURL: user.photoURL ?? "",
          googleId: null,
          token: null,
        );
      } else if (userType == 'Assistant') {
        await DatabaseService().createAssistantUserData(
          uid: user.uid,
          usertype: userType,
          username: username,
          email: user.email!,
          photoURL: user.photoURL ?? "",
          googleId: null,
          token: null,
          fieldOfAssist: activityField!,
          experienceAge: experienceAssistant!,
          diplomaPath: diplomaPath!,
          cvPath: cvPath!,
        );
      } else if (userType == 'Consultant') {
        await DatabaseService().createConsultantUserData(
          uid: user.uid,
          usertype: userType,
          username: username,
          email: user.email!,
          photoURL: user.photoURL ?? "",
          googleId: null,
          token: null,
          diplomaPath: diplomaPath!,
          cvPath: cvPath!,
          experienceAge: experienceConsultant!,
        );
      } else {
        throw Exception('invalid-user-type');
      }
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

  Future<UserHandler> signUpWithGoogle(BuildContext context, domain) async {
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
            await DatabaseService().createUserData(
              uid: user.uid,
              googleId: googleUser.id,
              username: username,
              email: user.email!,
              photoURL: user.photoURL!,
              domain: domain,
              token: null,
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
