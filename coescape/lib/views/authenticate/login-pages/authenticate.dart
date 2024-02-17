import 'package:flutter/material.dart';

import '../../../services/auth.dart';
import 'signin.dart';
import 'register.dart';

class Authenticate extends StatefulWidget {
  final AuthService authService;
  final String category;
  const Authenticate({
    super.key,
    required this.authService,
    required this.category,
  });

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() => setState(() => showSignIn = !showSignIn);

  @override
  Widget build(BuildContext context) {
    return !showSignIn
        ? SignIn(
            toggleView: toggleView,
            authService: widget.authService,
          )
        : Register(
            toggleView: toggleView,
            authService: widget.authService,
            category: widget.category,
          );
  }
}
