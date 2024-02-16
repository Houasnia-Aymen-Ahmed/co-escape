import 'package:ascent/models/user.dart';

class AssistantUser extends AppUser {
  final String fieldOfAssist;
  AssistantUser({
    required super.uid,
    required super.usertype,
    required super.username,
    required super.email,
    required super.photoURL,
    required super.domain,
    required super.googleId,
    required super.token,
    required this.fieldOfAssist,
  });
}
