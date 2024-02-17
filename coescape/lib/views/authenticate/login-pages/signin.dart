import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../services/auth.dart';
import '../../../utils/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  final AuthService authService;
  const SignIn({
    super.key,
    required this.toggleView,
    required this.authService,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _error = "", title = "Login";
  bool _isLoading = false;
  double elementWidth = 343.0;

  void buttonController() async {
    setState(() {
      _error = "";
      _isLoading = true;
    });
    try {
      dynamic result = await widget.authService.signInWithGoogle(context);
      if (result == null) {
        setState(() {
          _isLoading = false;
          _error =
              "Couldn't Register with those Credientials, Please try again";
        });
      }
    } on Exception catch (e) {
      if (e.toString().contains("sign-in-aborted")) {
        setState(() {
          _isLoading = false;
          _error = "Sign in aborted";
        });
      } else if (e.toString().contains("sign-in-failed")) {
        setState(() {
          _isLoading = false;
          _error = "Failed to sign in, Please try again";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "An error occured, Please try again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: const Color(0xFF91919F),
                      decoration: textInputDecoration.copyWith(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Color(0xFF91919F)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFF91919F),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: const Color(0xFF91919F),
                      decoration: textInputDecoration.copyWith(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Color(0xFF91919F)),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFF91919F),
                        ),
                      ),
                      autocorrect: false,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ! Call sign in function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10c58c),
                minimumSize: Size(elementWidth, 56),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have an account?",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.1),
                    ),
                  ),
                  onPressed: () => widget.toggleView(),
                  child: Text(
                    "Create one",
                    style: txt().copyWith(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            orDivider,
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 56,
                maxWidth: elementWidth,
              ),
              child: SignInButton(
                Buttons.google,
                padding: const EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                text: "$title with HNS-RE2SD",
                onPressed: buttonController,
              ),
            ),
            if (_error != "")
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: elementWidth),
                  child: Text(
                    _error,
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
