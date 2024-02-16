import 'package:ascent/views/authenticate/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_handler.dart';
import '../../services/auth.dart';
import '../../services/databases.dart';

import 'user_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();
    final AuthService authService = AuthService();
    return Consumer<UserHandler?>(
      builder: (context, user, _) {
        if (user == null) {
          return CategorySelector(
            authService: authService,
            databaseService: databaseService,
          );
        } else {
          return UserWrapper(
            user: user,
            databaseService: databaseService,
            authService: authService,
          );
        }
      },
    );
  }
}
