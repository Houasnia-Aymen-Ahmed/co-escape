import 'package:ascent/models/user.dart';

class StartupOwner extends AppUser {
  final bool isStartup;
  final Map<String, dynamic>? startup;
  final Map<String, dynamic>? idea;
  StartupOwner({
    required super.uid,
    required super.username,
    required super.email,
    required super.photoURL,
    required super.domain,
    required super.googleId,
    required super.token,
    required this.isStartup,
    this.startup,
    this.idea,
  });
}
