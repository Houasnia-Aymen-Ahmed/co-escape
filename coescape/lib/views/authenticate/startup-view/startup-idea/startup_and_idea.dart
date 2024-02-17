import 'package:ascent/services/auth.dart';
import 'package:ascent/utils/click_to_upload.dart';
import 'package:ascent/utils/popups/email_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/storage.dart';
import '../forms/idea_form.dart';
import '../forms/startup_form.dart';

class StartupAndIdeaView extends StatefulWidget {
  final String formType;
  final Map<String, dynamic> info;
  const StartupAndIdeaView({
    super.key,
    required this.formType,
    required this.info,
  });

  @override
  State<StartupAndIdeaView> createState() => _StartupAndIdeaViewState();
}

class _StartupAndIdeaViewState extends State<StartupAndIdeaView> {
  late FirebaseStorageService storageService;
  bool isLoading = false, isError = false;
  AuthService authService = AuthService();
  Map<String, String>? otherData;

  @override
  void initState() {
    super.initState();
    storageService = FirebaseStorageService();
  }

  void handleFormChanged(Map<String, String> updatedData) {
    setState(() {
      otherData = updatedData;
    });
  }

  void signUpStartupOwner() {
    if (widget.formType == "startup") {
      widget.info["hasInvestor"] =
          otherData!['investor'] == 'Yes' ? true : false;
      widget.info["hasMarketingPlan"] =
          otherData!['marketing'] == 'Yes' ? true : false;
      authService.signUpWithEmailAndPassword(
        username: widget.info["username"]!,
        email: widget.info["email"]!,
        password: widget.info["password"]!,
        domain: widget.info["domain"]!,
        userType: widget.info["userType"]!,
        hasInvestor: widget.info['hasInvestor'],
        marketingStrategyAndBMC: widget.info['hasMarketingPlan'],
      );
    } else {
      widget.info["hasInvestor"] =
          otherData!['investor'] == 'Yes' ? true : false;
      authService.signUpWithEmailAndPassword(
        username: widget.info["username"]!,
        email: widget.info["email"]!,
        password: widget.info["password"]!,
        domain: widget.info["domain"]!,
        userType: widget.info["userType"]!,
        hasInvestor: widget.info['hasInvestor'],
        marketingStrategyAndBMC: widget.info['hasMarketingPlan'],
      );
    }
    showDialog(
      context: context,
      builder: (context) => const EmailPopup(
        title: "Startup",
      ),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    const double elementWidth = 300;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                widget.formType == "startup" ? "Startup" : "Idea",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: const Color(0xFF10c58c),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Fill this form so we can help you properly",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 50),
              widget.formType == "startup"
                  ? StartupForm(onFormChanged: handleFormChanged)
                  : IdeaForm(onFormChanged: handleFormChanged),
              const ClickToUpload(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    signUpStartupOwner();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10c58c),
                    minimumSize: const Size(elementWidth, 56),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
