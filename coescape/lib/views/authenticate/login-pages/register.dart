import 'package:ascent/utils/popups/email_popup.dart';
import 'package:ascent/views/authenticate/shared-view/experience_and_documents.dart';
import 'package:ascent/views/authenticate/startup-view/startup-idea/startup_or_idea_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/auth.dart';
import '../../../utils/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final AuthService authService;
  final String category;

  const Register({
    super.key,
    required this.toggleView,
    required this.authService,
    required this.category,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  String _error = "", _username = "", _domain = "", _email = "", _password = "";
  String? _activityField;
  bool _isLoading = false, _isChecked = false, _obsecureText = true;
  double elementWidth = 343.0;

  void continueBtnCtrl() async {
    if (_registerFormKey.currentState!.validate()) {
      if (widget.category == "Assitant" && _activityField == null) {
        setState(() {
          _error = "Please select an activity field";
        });
        return;
      } else if (widget.category == "Investor") {
        widget.authService.signUpWithEmailAndPassword(
          username: _username,
          email: _email,
          password: _password,
          domain: _domain,
          userType: widget.category,
        );
        showDialog(
          context: context,
          builder: (context) => const EmailPopup(
            title: "Investor",
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
        return;
      }

      final Map<String, String> info = {
        "username": _username,
        "domain": _domain,
        "email": _email,
        "password": _password,
        "userType": widget.category,
        "activityField": _activityField ?? ""
      };
      final Map<String, Widget> categoryRoutes = {
        "Startup Owner": StartupOrIdeaSelector(info: info),
        "Assitant": ExperienceAndDocuments(info: info),
        "Consultant": ExperienceAndDocuments(info: {
          "username": _username,
          "email": _email,
          "password": _password,
          "userType": widget.category,
        }),
      };

      final Widget? destinationPage = categoryRoutes[widget.category];

      if (destinationPage != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong"),
          ),
        );
      }
    }
  }

  void googleSignInBtnController() async {
    try {
      dynamic result =
          await widget.authService.signUpWithGoogle(context, _domain);
      if (result == null) {
        setState(() {
          _isLoading = false;
          _error =
              "Couldn't Register with those Credientials, Please try again";
        });
      }
    } on Exception catch (e) {
      if (e.toString().contains("sign-up-aborted")) {
        setState(() {
          _isLoading = false;
          _error = "Sign up aborted";
        });
      } else if (e.toString().contains("sign-up-failed")) {
        setState(() {
          _isLoading = false;
          _error = "Failed to sign up, Please try again";
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
          "Sign up",
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
              key: _registerFormKey,
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
                        hintText: "Username",
                        hintStyle: const TextStyle(color: Color(0xFF91919F)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0xFF91919F),
                        ),
                      ),
                      validator: (val) {
                        return val!.isEmpty ? "Please enter a Username" : null;
                      },
                      onChanged: (val) => setState(
                        () {
                          _username = val;
                        },
                      ),
                    ),
                  ),
                  if (widget.category == "Startup Owner" ||
                      widget.category == "Investor")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        cursorColor: const Color(0xFF91919F),
                        decoration: textInputDecoration.copyWith(
                          hintText: "Domain",
                          hintStyle: const TextStyle(color: Color(0xFF91919F)),
                          prefixIcon: const Icon(
                            Icons.domain,
                            color: Color(0xFF91919F),
                          ),
                        ),
                        validator: (val) {
                          return val!.isEmpty ? "Please enter a Domain" : null;
                        },
                        onChanged: (val) => setState(
                          () => _domain = val,
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
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Color(0xFF91919F)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFF91919F),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter an Email";
                        } else if (!val.contains('@')) {
                          return "Please enter a valid Email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => setState(
                        () => _email = val,
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
                        suffixIcon: IconButton(
                          icon: _obsecureText
                              ? const Icon(
                                  Icons.visibility_rounded,
                                )
                              : const Icon(
                                  Icons.visibility_off_rounded,
                                ),
                          onPressed: () => setState(
                            () => _obsecureText = !_obsecureText,
                          ),
                          color: const Color(0xFF10C58C),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFF91919F),
                        ),
                      ),
                      obscureText: _obsecureText,
                      autocorrect: false,
                      validator: (val) {
                        return val!.length < 8
                            ? "The password must be at least 8 characters long"
                            : null;
                      },
                      onChanged: (val) => setState(
                        () => _password = val,
                      ),
                    ),
                  ),
                  if (widget.category == "Assitant")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10,
                      ),
                      child: dropDownBtn(
                        items: ["Finance", "Marketing"],
                        hint: "Select your activity field",
                        val: _activityField,
                        onChanged: (String? newValue) {
                          setState(() {
                            _activityField = newValue!;
                            _error = "";
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CheckboxListTile(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
                checkColor: Colors.white,
                activeColor: const Color(0xFF10C58C),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By signing up, you agree to the",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Terms of Service and Privacy Policy",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10C58C),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: elementWidth,
              child: ElevatedButton(
                onPressed: () {
                  continueBtnCtrl();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10c58c),
                  minimumSize: Size(elementWidth, 56),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
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
                    "Sign In",
                    style: txt().copyWith(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            /* const SizedBox(height: 20),
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
                text: "Sign up with HNS-RE2SD",
                onPressed: buttonController,
              ),
            ), */
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
