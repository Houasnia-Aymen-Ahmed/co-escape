import 'package:flutter/material.dart';

import '../../models/user.dart';

class StartupOwnerView extends StatefulWidget {
  final AppUser user;
  const StartupOwnerView({super.key, required this.user});

  @override
  State<StartupOwnerView> createState() => _StartupOwnerViewState();
}

class _StartupOwnerViewState extends State<StartupOwnerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Owner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      ),
    );
  }
}
