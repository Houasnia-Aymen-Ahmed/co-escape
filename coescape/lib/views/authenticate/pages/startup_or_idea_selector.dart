import 'package:ascent/views/authenticate/pages/type_of_owner/startup_and_idea.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupOrIdeaSelector extends StatefulWidget {
  final Map<String, String> info;
  const StartupOrIdeaSelector({super.key, required this.info});

  @override
  State<StartupOrIdeaSelector> createState() => _StartupOrIdeaSelectorState();
}

class _StartupOrIdeaSelectorState extends State<StartupOrIdeaSelector> {
  final double elementWidth = 343;

  void buttonController(String viewType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StartupAndIdeaView(formType: viewType, info: widget.info),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup or Idea ?"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Do you already have a startup or you have an idea that requires to be sharpened',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                buttonController("startup");
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
                "Startup",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                buttonController("idea");
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
                "Idea",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
