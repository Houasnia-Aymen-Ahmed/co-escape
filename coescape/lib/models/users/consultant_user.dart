import 'package:ascent/models/user.dart';

class ConsultantUser extends AppUser {
  final String diplomaPath;
  final String cvPath;
  final int experienceAge;
  ConsultantUser({
    required super.uid,
    required super.usertype,
    required super.username,
    required super.email,
    required super.photoURL,
    required super.googleId,
    required super.token,
    required this.diplomaPath,
    required this.cvPath,
    required this.experienceAge,
  });
}
