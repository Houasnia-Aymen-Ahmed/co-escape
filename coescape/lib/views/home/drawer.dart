import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth.dart';
import '../../services/databases.dart';
import '../../utils/constants.dart';

class BuildDrawer extends StatelessWidget {
  final AuthService authService;
  final DatabaseService databaseService;
  final AppUser? user;

  const BuildDrawer({
    super.key,
    required this.authService,
    required this.databaseService,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Drawer(
          backgroundColor: Colors.blue[100],
          elevation: 10,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    userAccountDrawerHeader(
                      username: user?.username ?? "user",
                      email: user?.email ?? "user@hns-re2sd.dz",
                      profileURL: user?.photoURL ?? "",
                    ),
                    ListTile(
                      title: const Text("Settings"),
                      leading: const Icon(Icons.settings),
                      onTap: () {
                        // Put function here
                      },
                    ),
                    ListTile(
                      title: const Text("About"),
                      leading: const Icon(Icons.info),
                      onTap: () {
                        // Put function here
                      },
                    ),
                    ListTile(
                      title: const Text("Logout"),
                      leading: const Icon(Icons.logout),
                      onTap: () {
                        authService.logout(context);
                      },
                    ),
                  ],
                ),
              ),
              drawerFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
