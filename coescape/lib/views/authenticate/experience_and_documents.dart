import 'dart:io';

import 'package:ascent/utils/click_to_upload.dart';
import 'package:ascent/utils/constants.dart';
import 'package:ascent/utils/popups/rejected_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceAndDocuments extends StatefulWidget {
  final List<String> info;
  const ExperienceAndDocuments({super.key, required this.info});

  @override
  State<ExperienceAndDocuments> createState() => _ExperienceAndDocumentsState();
}

class _ExperienceAndDocumentsState extends State<ExperienceAndDocuments> {
  final _experienceAndDocsKey = GlobalKey<FormState>();
  final File? diplomaFile = null, cvFile = null;
  int experience = 0;
  bool _isDiplomaError = false;
  bool _isCvError = false;

  void submitButton(BuildContext context) {
    if (_experienceAndDocsKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const RejectedPopup(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double elementWidth = 300;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Experience and documents"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _experienceAndDocsKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                showHeading("Years of expertise"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 5,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: const Color(0xFF10c58c),
                    decoration: textInputDecoration.copyWith(
                      border: outLineBorder(color: const Color(0xFF10c58c)),
                      enabledBorder:
                          outLineBorder(color: const Color(0xFF10c58c)),
                      focusedBorder:
                          outLineBorder(color: const Color(0xFF10c58c)),
                      filled: false,
                    ),
                    validator: (val) {
                      return val!.isEmpty
                          ? "Please enter your number of expertise years"
                          : null;
                    },
                    onChanged: (val) => setState(
                      () => experience = int.parse(val),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                showHeading("Diploma"),
                ClickToUpload(
                  onErrorChanged: (value) {
                    setState(() {
                      _isDiplomaError = value;
                    });
                  },
                ),
                if (_isDiplomaError)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: elementWidth),
                      child: Text(
                        "Please, you must upload your Diploma",
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 50),
                showHeading("CV"),
                ClickToUpload(
                  onErrorChanged: (value) {
                    setState(() {
                      _isCvError = value;
                    });
                  },
                ),
                if (_isCvError)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: elementWidth),
                      child: Text(
                        "Please, you must upload your CV",
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      submitButton(context);
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
      ),
    );
  }
}
