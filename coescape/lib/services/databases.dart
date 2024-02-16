import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/users/investors_user.dart';

import 'auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();

  // collection reference
  CollectionReference userColl =
      FirebaseFirestore.instance.collection("UsersCollection");
  CollectionReference startupOwnerColl =
      FirebaseFirestore.instance.collection("StartupOwnersCollection");
  CollectionReference investorColl =
      FirebaseFirestore.instance.collection("InvestorsCollection");
  CollectionReference assistantColl =
      FirebaseFirestore.instance.collection("AssistantsCollection");
  CollectionReference consultantColl =
      FirebaseFirestore.instance.collection("ConsultantsCollection");

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

  Future createUserData({
    required String uid,
    required String username,
    required String email,
    required String photoURL,
    required String domain,
    String? googleId,
    String? token,
  }) async {
    return await userColl.doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'domain': domain,
      'googleId': googleId ?? "googleId",
      'token': token ?? "token",
    });
  }

  Future createStartupOwnerData({
    required String uid,
    required String username,
    required String email,
    required String photoURL,
    required String domain,
    required String? googleId,
    required String? token,
    required String marketingStrategyAndBMC,
    required bool hasInvestor,
  }) async {
    DocumentReference userDoc = userColl.doc(uid);
    await userDoc.set({
      'uid': uid,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'domain': domain,
      'googleId': googleId,
      'token': token,
      'investors': hasInvestor,
      'marketingStrategyAndBMC': marketingStrategyAndBMC,
    });
  }

  Future createInvestorUserData({
    required String uid,
    required String usertype,
    required String username,
    required String email,
    required String photoURL,
    required String domain,
    required String? googleId,
    required String? token,
  }) async {
    DocumentReference investorDoc = investorColl.doc(uid);
    await investorDoc.set({
      'uid': uid,
      'usertype': usertype,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'domain': domain,
      'googleId': googleId,
      'token': token,
    });
  }

  Future createAssistantUserData({
    required String uid,
    required String usertype,
    required String username,
    required String email,
    required String photoURL,
    required String domain,
    required String? googleId,
    required String? token,
    required String fieldOfAssist,
  }) async {
    DocumentReference assistantDoc = assistantColl.doc(uid);
    await assistantDoc.set({
      'uid': uid,
      'usertype': usertype,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'domain': domain,
      'googleId': googleId,
      'token': token,
      'fieldOfAssist': fieldOfAssist,
    });
  }

  /* Future updateUserData({
    String? uid,
    String? usertype,
    String? username,
    String? email,
    String? photoURL,
    String? domain,
    String? googleId,
    String? token,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": usrUid,
      "usertype": usertype,
      "username": username,
      "email": email,
      "photoURL": photoURL,
      "domain": domain,
      "googleId": googleId,
      "token": token,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await userColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  } */

  Future updateUserData({
    String? uid,
    String? usertype,
    String? username,
    String? email,
    String? photoURL,
    String? domain,
    String? googleId,
    String? token,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;

    Map<String, dynamic> map = {
      "uid": usrUid,
      "usertype": usertype,
      "username": username,
      "email": email,
      "photoURL": photoURL,
      "domain": domain,
      "googleId": googleId,
      "token": token,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await userColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  }

  Future updateStartupOwnerData({
    String? uid,
    String? usertype,
    String? username,
    String? email,
    String? photoURL,
    String? domain,
    String? googleId,
    String? token,
    List<String>? investors,
    String? financeStrategy,
    String? marketingStrategyAndBMC,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": usrUid,
      "usertype": usertype,
      "username": username,
      "email": email,
      "photoURL": photoURL,
      "domain": domain,
      "googleId": googleId,
      "token": token,
      "investors": investors,
      "financeStrategy": financeStrategy,
      "marketingStrategyAndBMC": marketingStrategyAndBMC,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await userColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  }

  Future updateInvestorUserData({
    String? uid,
    String? usertype,
    String? username,
    String? email,
    String? photoURL,
    String? domain,
    String? googleId,
    String? token,
    int? experienceAge,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": usrUid,
      "usertype": usertype,
      "username": username,
      "email": email,
      "photoURL": photoURL,
      "domain": domain,
      "googleId": googleId,
      "token": token,
      "experienceAge": experienceAge,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await investorColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  }

  Future updateAssistantUserData({
    String? uid,
    String? usertype,
    String? username,
    String? email,
    String? photoURL,
    String? domain,
    String? googleId,
    String? token,
    String? fieldOfAssist,
  }) async {
    String usrUid = uid ?? _auth.currentUsr!.uid;
    Map<String, dynamic> map = {
      "uid": usrUid,
      "usertype": usertype,
      "username": username,
      "email": email,
      "photoURL": photoURL,
      "domain": domain,
      "googleId": googleId,
      "token": token,
      "fieldOfAssist": fieldOfAssist,
    };
    for (var entry in map.entries) {
      if (entry.value != null) {
        await assistantColl.doc(usrUid).update({
          entry.key.toString(): entry.value,
        });
      }
    }
  }

  AppUser _currentUserFromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
      return AppUser(
        uid: doc["uid"] ?? 'uid',
        usertype: doc["usertype"] ?? 'usertype',
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
        domain: doc["domain"] ?? 'domain',
        googleId: doc["googleId"] ?? 'googleId',
        token: doc["token"] ?? "token",
      );
    } else {
      return AppUser(
        uid: 'uid',
        usertype: 'usertype',
        username: 'username',
        email: "email",
        photoURL: "photoURL",
        domain: 'domain',
        googleId: 'googleId',
        token: "token",
      );
    }
  }

  /* StartupOwner _currentStartupOwnerFromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      isUserDataExist = true;
      Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
      return StartupOwner(
        uid: doc["uid"] ?? 'uid',
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
        domain: doc["domain"] ?? 'domain',
        googleId: doc["googleId"] ?? 'googleId',
        token: doc["token"] ?? "token",
        hasInvestor: doc["hasInvestor"] ?? false,
        marketingStrategyAndBMC:
            doc["marketingStrategyAndBMC"] ?? 'marketingStrategyAndBMC',
      );
    } else {
      isUserDataExist = false;
      return StartupOwner(
        uid: 'uid',
        username: 'username',
        email: "email",
        photoURL: "photoURL",
        domain: 'domain',
        googleId: 'googleId',
        token: "token",
        hasInvestor: false,
        marketingStrategyAndBMC: 'marketingStrategyAndBMC',
      );
    }
  } */

  InvestorUser _currentInvestorUserFromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
      return InvestorUser(
        uid: doc["uid"] ?? 'uid',
        usertype: doc["usertype"] ?? 'usertype',
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
        domain: doc["domain"] ?? 'domain',
        googleId: doc["googleId"] ?? 'googleId',
        token: doc["token"] ?? "token",
        experienceAge: doc["experienceAge"] ?? 0,
      );
    } else {
      return InvestorUser(
        uid: 'uid',
        usertype: 'usertype',
        username: 'username',
        email: "email",
        photoURL: "photoURL",
        domain: 'domain',
        googleId: 'googleId',
        token: "token",
        experienceAge: 0,
      );
    }
  }

  /* AssistantUser _currentAssistantUserFromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
      return AssistantUser(
        uid: doc["uid"] ?? 'uid',
        username: doc["username"] ?? 'username',
        email: doc["email"] ?? "email",
        photoURL: doc["photoURL"] ?? "photoURL",
        domain: doc["domain"] ?? 'domain',
        googleId: doc["googleId"] ?? 'googleId',
        token: doc["token"] ?? "token",
        fieldOfAssist: doc["fieldOfAssist"] ?? 'fieldOfAssist',
      );
    } else {
      return AssistantUser(
        uid: 'uid',
        username: 'username',
        email: "email",
        photoURL: "photoURL",
        domain: 'domain',
        googleId: 'googleId',
        token: "token",
        fieldOfAssist: 'fieldOfAssist',
      );
    }
  } */

  Stream<AppUser> getUserDataStream(String userId) {
    return userColl.doc(userId).snapshots().map(_currentUserFromSnapshots);
  }

  /* Stream<StartupOwner> getStartupOwnerDataStream(String userId) {
    return userColl
        .doc(userId)
        .snapshots()
        .map(_currentStartupOwnerFromSnapshots);
  } */

  Stream<InvestorUser> getInvestorUserDataStream(String userId) {
    return investorColl
        .doc(userId)
        .snapshots()
        .map(_currentInvestorUserFromSnapshots);
  }

  /* Stream<AssistantUser> getAssistantUserDataStream(String userId) {
    return userColl
        .doc(userId)
        .snapshots()
        .map(_currentAssistantUserFromSnapshots);
  } */
}
