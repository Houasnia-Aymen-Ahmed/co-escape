import 'package:ascent/models/user.dart';

class AssistantUser extends AppUser {
  final String fieldOfAssist;
  final int experienceAge;
  final String diplomaPath;
  final String cvPath;
  //constructor
  AssistantUser({
    required super.uid,
    required super.usertype,
    required super.username,
    required super.email,
    required super.photoURL,
    required super.googleId,
    required super.token,
    required this.fieldOfAssist,
    required this.experienceAge,
    required this.diplomaPath,
    required this.cvPath,
  });
}
