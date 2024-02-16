import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcceptedPopup extends StatefulWidget {
  const AcceptedPopup({super.key});
  @override
  State<AcceptedPopup> createState() => _AcceptedPopupState();
}

class _AcceptedPopupState extends State<AcceptedPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

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
          "Congratulations!",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: const Color(0xFF10c58c),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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
            const SizedBox(height: 20),
            Text(
              "You've been accepted",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            const Icon(
              Icons.check_circle,
              color: Color(0xFF10c58c),
              size: 50,
            ),
            const SizedBox(height: 50),
            Text(
              "We hope you enjoy your journey with us!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
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
