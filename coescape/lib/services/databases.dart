import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();
  final String? uid;
  bool isUserDataExist = true;
  bool isModuleDataExist = true;
  DatabaseService({this.uid});

  CollectionReference userColl =
      FirebaseFirestore.instance.collection("UserCollection");

  Future updateUserData({
    required String uid,
    required String userName,
    required String email,
    required String photoURL,
  }) async {
    DocumentReference userDoc = userColl.doc(uid);
    await userDoc.set({
      'uid': uid,
      'username': userName,
      'email': email,
      'photoURL': photoURL,
    });
  }

  Future<bool> isUserRegistered(String email) async {
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
  }

  Future updateUserSpecificData({
    String? uid,
    String? username,
    String? email,
    String? photoURL,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": uid,
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
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
      );
    } else {
      isUserDataExist = false;
      return AppUser(
        uid: 'uid',
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
