import 'dart:convert';
import 'dart:developer';

import 'package:basicproduct/State/FormKeys/FormKeys.dart';
import 'package:basicproduct/Utils/App.dart';
import 'package:basicproduct/Utils/Loader/LoaderProvider.dart';
import 'package:basicproduct/Utils/Network/NetworkInterface.dart';
import 'package:basicproduct/Utils/Network/RequestHelper.dart';
import 'package:basicproduct/Widgets/Buttons/AppButton.dart';
import 'package:basicproduct/Widgets/TextFieldWidget/AppTextFiled.dart';
import 'package:basicproduct/Widgets/UtilsWidget/StatusBarWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends HookWidget {
  static const String route = "/SignUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNameController = useTextEditingController();
    final userEmailController = useTextEditingController();
    final userMobileController = useTextEditingController();
    final userPasswordController = useTextEditingController();
    final userConfirmPasswordController = useTextEditingController();
    return StatusBarWrapper(
      brightness: SystemUiOverlayStyle.dark,
      child: Form(
        key: FormKeys.signUpFormKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              SafeArea(
                bottom: false,
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color(0xFF222E4D),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                ),
                child: Text(
                  "SIGNUP",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.sp,
                      color: const Color(0xFF222E4D)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextFiled(
                controller: userNameController,
                prefix: LineIcons.at,
                suffix: null,
                nextAction: TextInputAction.next,
                hint: "UserName",
                onValidate: (val) {
                  if (val.length < 4) {
                    return "User Name should ber of 4 Char";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextFiled(
                controller: userEmailController,
                prefix: LineIcons.envelopeAlt,
                suffix: null,
                nextAction: TextInputAction.next,
                hint: "Email",
                onValidate: (val) {
                  if (val.isEmpty) {
                    return "Email Required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextFiled(
                controller: userMobileController,
                prefix: LineIcons.mobilePhone,
                suffix: null,
                type: TextInputType.number,
                nextAction: TextInputAction.next,
                hint: "Mobile",
                onValidate: (val) {
                  if (val.length < 10 && val.length > 10) {
                    return "Mobile number should be 10 digit";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextFiled(
                controller: userPasswordController,
                isPassword: true,
                prefix: LineIcons.lock,
                suffix: null,
                onValidate: (val) {
                  if (val.isEmpty) {
                    return "Password Required";
                  }
                  return null;
                },
                hint: "Password",
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextFiled(
                controller: userConfirmPasswordController,
                isPassword: true,
                prefix: LineIcons.lock,
                suffix: null,
                onValidate: (val) {
                  if (val != userPasswordController.text) {
                    return "Password Not Matching";
                  }
                  return null;
                },
                hint: "Confirm Password",
              ),
              SizedBox(
                height: 40.h,
              ),
              AppButton(
                  onClick: () {
                    if (FormKeys.signUpFormKey.currentState!.validate()) {
                      context.read<LoaderProvider>().isLoading = true;
                      RequestHelper.post(
                        url: "https://fakestoreapi.com/users",
                        data: {
                          "email": userEmailController.text,
                          "username": userNameController.text,
                          "password": userPasswordController.text,
                          "name": {
                            "firstname": userNameController.text,
                            "lastname": ""
                          },
                          "address": {
                            "city": 'kilcoole',
                            "street": '7835 new road',
                            "number": 3,
                            "zipcode": '12926-3874',
                            "geolocation": {
                              "lat": '-37.3159',
                              "long": '81.1496'
                            }
                          },
                          "phone": userMobileController.text,
                        },
                        networkInterface: NetworkInterface(
                          onSuccess: (data) {
                            context.read<LoaderProvider>().isLoading = false;
                            Navigator.pop(context);
                          },
                          onError: (errorMap) {
                            App.showError(
                              message: errorMap['message'].toString(),
                              context: context,
                            );
                            context.read<LoaderProvider>().isLoading = false;
                          },
                        ),
                      );
                    }
                  },
                  text: "Signup"),
              Container(
                margin: EdgeInsets.only(
                  top: 15.h,
                  left: 20.w,
                  right: 20.w,
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF6F798D).withOpacity(0.15),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "OR",
                      style: GoogleFonts.rubik(
                        color: const Color(0xFF6F798D),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFF6F798D).withOpacity(0.15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              AppButton(
                  onClick: () {
                    Navigator.pop(context);
                  },
                  text: "Already Have Account ?",
                  type: ButtonType.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
