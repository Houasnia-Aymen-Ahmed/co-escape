import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth.dart';
import '../services/databases.dart';

class Home extends StatelessWidget {
  final AuthService authService;
  final DatabaseService databaseService;
  final AppUser user;
  const Home({
    super.key,
    required this.authService,
    required this.databaseService,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
