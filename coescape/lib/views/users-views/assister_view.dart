import 'package:flutter/material.dart';

import '../../models/user.dart';

class AssistantView extends StatelessWidget {
  final AppUser user;
  const AssistantView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assistant"),
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
