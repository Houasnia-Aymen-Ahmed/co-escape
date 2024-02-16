import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import '../../services/databases.dart';
import 'authenticate.dart';

class CategorySelector extends StatelessWidget {
  final AuthService authService;
  final DatabaseService databaseService;
  const CategorySelector({
    super.key,
    required this.authService,
    required this.databaseService,
  });

  List<Widget> buildButtons(BuildContext context) {
    final List<String> options = [
      "Startup Owner",
      "Assitant",
      "Consultant",
      "Investor",
    ];

    return [
      for (var i = 0; i < 4; i++)
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(
                    authService: authService,
                    category: options[i],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10c58c),
              minimumSize: const Size(343, 115),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              options[i],
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Text(
            "Select your category",
            style: GoogleFonts.poppins(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(flex: 1),
          ...buildButtons(context),
          const Spacer(flex: 1),
        ],
      )),
    );
  }
}
