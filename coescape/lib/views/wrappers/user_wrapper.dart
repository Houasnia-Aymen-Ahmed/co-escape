import 'package:ascent/views/users-views/investor_view.dart';
import 'package:ascent/views/users-views/starup_owner_view.dart';
import 'package:flutter/material.dart';

import '../../components/error_pages.dart';
import '../../components/loading.dart';
import '../../models/user.dart';
import '../../models/user_handler.dart';
import '../../services/auth.dart';
import '../../services/databases.dart';
import '../home/home.dart';
import '../users-views/assister_view.dart';
import '../users-views/consultor_view.dart';

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
          if (user.usertype == "Startup Owner") {
            return StartupOwnerView(user: user);
          } else if (user.usertype == "Investor") {
            return InvestorView(user: user);
          } else if (user.usertype == "Assitant") {
            return AssistantView(user: user);
          } else if (user.usertype == "Consultant") {
            return ConsultantView(user: user);
          } else {
            return Home(user: user);
          }
        }
      },
    );
  }
}
