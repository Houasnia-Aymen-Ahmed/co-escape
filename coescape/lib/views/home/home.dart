import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth.dart';
import '../../services/databases.dart';
import '../../services/notif.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  final AppUser user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService databaseService = DatabaseService();
  final NotificationService notificationService = NotificationService();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    notificationService.initialize(context);
  }

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
        user: widget.user,
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Home'),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () => notificationService.sendNotif(
                widget.user.token!,
                widget.user,
              ),
            ),
          )
        ],
      ),
    );
  }
}
