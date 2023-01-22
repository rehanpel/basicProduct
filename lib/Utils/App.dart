import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App {
  static showError({required String message, required BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.rubik(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
