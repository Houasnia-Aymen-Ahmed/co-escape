import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../services/auth.dart';
import '../../utils/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final AuthService authService;
  const Register({
    super.key,
    required this.toggleView,
    required this.authService,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _error = "";
  String? value;
  bool _isLoading = false;

  void buttonController() async {
    try {
      dynamic result = await widget.authService.signUpWithGoogleProvider();
      if (result == null) {
        setState(() {
          _isLoading = false;
          _error =
              "Couldn't Register with those Credientials, Please try again";
        });
      }
    } on Exception catch (e) {
      print(e.toString());
      if (e.toString().contains("not-hns")) {
        setState(() {
          _isLoading = false;
          _error = "You must use an HNS-RE2SD account";
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = "Unhandled exception occured, Please try again";
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
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.blue[700]!,
                      Colors.blue[100]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 2,
                    color: Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 0.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Sign up",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      /* Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: dropDownBtn(
                                hint: "Choose type",
                                isExpanded: true,
                                textColor: Colors.white,
                                onChanged: (String? newValue) {
                                  setState(() => value = newValue);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9.0,
                                vertical: 8.0,
                              ),
                              child: dropDownBtn(
                                hint: "Choose grade",
                                isDisabled: false,
                                isExpanded: true,
                                textColor: Colors.white,
                                onChanged: null,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9.0,
                                vertical: 8.0,
                              ),
                              child: dropDownBtn(
                                hint: "Choose speciality",
                                isDisabled: false,
                                isExpanded: true,
                                textColor: Colors.white,
                                onChanged: null,
                              ),
                            ),
                          ),
                        ],
                      ), */
                      Transform.scale(
                        scale: 1.25,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 50),
                          child: SignInButton(
                            Buttons.google,
                            padding: const EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            text: "Sign up with HNS-RE2SD",
                            onPressed: buttonController,
                          ),
                        ),
                      ),
                      if (_error != "")
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 275),
                          child: Text(
                            _error,
                            style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
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
                              "Sign In",
                              style: txt().copyWith(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
