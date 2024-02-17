import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailPopup extends StatefulWidget {
  const EmailPopup({super.key});

  @override
  State<EmailPopup> createState() => _EmailPopupState();
}

class _EmailPopupState extends State<EmailPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  String title = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            color: const Color(0xFF10c58c),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "You will hear from us soon via your mail!",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.email,
              size: 50,
              color: Color(0xFF10c58c),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
