import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();
  bool isUserDataExist = true;
  bool isModuleDataExist = true;

  CollectionReference userColl =
      FirebaseFirestore.instance.collection("UserCollection");

  Future updateUserData({
    required String uid,
    required String? googleId,
    required String username,
    required String email,
    required String photoURL,
  }) async {
    DocumentReference userDoc = userColl.doc(uid);
    await userDoc.set({
      'uid': uid,
      'googleId': googleId,
      'username': username,
      'email': email,
      'photoURL': photoURL,
    });
  }

  /* Future<bool> isUserRegistered(String email) async {
    try {
      QuerySnapshot querySnapshot = await userColl
          .where(
            'email',
            isEqualTo: email,
          )
          .limit(1)
          .get();
      if (querySnapshot.docs.isEmpty) return false;
      return true;
    } on Exception catch (_) {
      return false;
    }
  } */

  Future<bool> isUserRegistered(String googleId) async {
    try {
      QuerySnapshot userDoc = await userColl
          .where(
            'googleId',
            isEqualTo: googleId,
          )
          .limit(1)
          .get();
      return userDoc.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future updateUserSpecificData({
    String? uid,
    String? googleId,
    String? username,
    String? email,
    String? photoURL,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": uid,
      "googleId": googleId,
      "username": username,
      "email": email,
      "photoURL": photoURL,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await userColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  }

  AppUser _currentUserFromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      isUserDataExist = true;
      Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
      return AppUser(
        uid: doc["uid"] ?? 'uid',
        googleId: doc["googleId"] ?? 'googleId',
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
      );
    } else {
      isUserDataExist = false;
      return AppUser(
        uid: 'uid',
        googleId: 'googleId',
        username: 'username',
        email: "email",
        photoURL: "photoURL",
      );
    }
  }

  Stream<AppUser> getUserDataStream(String userId) {
    return userColl.doc(userId).snapshots().map(_currentUserFromSnapshots);
  }
}
