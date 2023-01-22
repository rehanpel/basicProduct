import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFiled extends HookWidget {
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final String hint;
  final bool isPassword;
  final TextInputType type;
  final TextInputAction nextAction;
  final String? Function(String val)? onValidate;

  const AppTextFiled(
      {Key? key,
      required this.controller,
      this.onValidate,
      this.isPassword = false,
      this.type = TextInputType.text,
      this.nextAction = TextInputAction.done,
      required this.prefix,
      required this.suffix,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordShow = useState<bool>(false);
    useEffect(() {
      if (isPassword) {
        passwordShow.value = true;
      }
      return () {};
    }, []);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        validator: (value) {
          if (onValidate != null) {
            return onValidate!(value ?? "");
          }
          return null;
        },
        obscureText: passwordShow.value,
        controller: controller,
        style: GoogleFonts.rubik(),
        keyboardType: type,
        textInputAction: nextAction,
        decoration: InputDecoration(
          prefixIcon: prefix == null
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      prefix,
                      color: const Color(0xFF7D8699),
                    ),
                  ],
                ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    passwordShow.value = !passwordShow.value;
                  },
                  icon: Icon(
                    !passwordShow.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : Icon(
                  suffix,
                  color: const Color(0xFF7D8699),
                ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.rubik(
            color: const Color(0xFF7D8699),
          ),
        ),
      ),
    );
  }
}
