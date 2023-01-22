import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final ButtonType type;

  const AppButton({
    Key? key,
    required this.onClick,
    required this.text,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 13.h),
      decoration: BoxDecoration(
        color: type == ButtonType.primary
            ? const Color(0xFF2A63F6)
            : const Color(0xFFF2F5F6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.rubik(
              color: type == ButtonType.primary
                  ? Colors.white
                  : const Color(0xFF6F798D),
            ),
          ),
        ),
      ),
    );
  }
}
