import 'package:flutter/material.dart';

import '../../components/error_pages.dart';
import '../../components/loading.dart';
import '../../models/user.dart';
import '../../models/user_handler.dart';
import '../../services/auth.dart';
import '../../services/databases.dart';
import '../home.dart';

class UserWrapper extends StatelessWidget {
  final UserHandler user;
  final DatabaseService databaseService;
  final AuthService authService;
  const UserWrapper({
    super.key,
    required this.user,
    required this.databaseService,
    required this.authService,
  });

  Future<Map<String, dynamic>> getData() async {
    // Get data and return it
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: databaseService.getUserDataStream(authService.currentUsr!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return ErrorPages(
            title: "Server Error",
            message: snapshot.error.toString(),
          );
        } else if (!snapshot.hasData) {
          return const ErrorPages(
            title: "Error 404: Not Found",
            message: "No user data available",
          );
        } else {
          AppUser user = snapshot.data!;
          return Home(
            authService: authService,
            databaseService: databaseService,
            user: user,
          );
        }
      },
    );
  }
}
