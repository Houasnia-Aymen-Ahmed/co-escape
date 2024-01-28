import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth.dart';
import '../services/databases.dart';
import 'home/drawer.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue[200],
        actions: [
          IconButton(
            onPressed: () => authService.logout(context),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      drawer: BuildDrawer(
        authService: authService,
        databaseService: databaseService,
        user: user,
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
