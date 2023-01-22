import 'package:basicproduct/Screens/Auth/SignUpScreen.dart';
import 'package:basicproduct/Screens/HomeBase.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:basicproduct/State/FormKeys/FormKeys.dart';
import 'package:basicproduct/Utils/App.dart';
import 'package:basicproduct/Utils/Extenstions.dart';
import 'package:basicproduct/Utils/Loader/LoaderProvider.dart';
import 'package:basicproduct/Utils/Network/NetworkInterface.dart';
import 'package:basicproduct/Utils/Network/RequestHelper.dart';
import 'package:basicproduct/Utils/PreferencesManager.dart';
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

class LoginScreen extends HookWidget {
  static const String route = "/";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNameController = useTextEditingController();
    final userPasswordController = useTextEditingController();

    checkLogin() {
      PreferencesManager().init(onComplete: () {
        final isLogin = PreferencesManager().pref!.getString("loginToken");
        print(isLogin);
        if (isLogin != null) {
          // Init Cart
          context.read<CartHelper>().getAllProduct();
          // Navigate
          HomeBase.route.pushReplace(context);
        }
      });
    }

    useEffect(() {
      Future.microtask(() {
        checkLogin();
      });
      return () {};
    }, []);
    return StatusBarWrapper(
      brightness: SystemUiOverlayStyle.dark,
      child: Form(
        key: FormKeys.loginFormKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30.h,
              ),
              SvgPicture.asset(
                "assets/login.svg",
                height: 250.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                  top: 10.h,
                ),
                child: Text(
                  "LOGIN",
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
                onValidate: (val) {
                  if (val.isEmpty) {
                    return "Please Enter UserName";
                  }
                  return null;
                },
                suffix: null,
                nextAction: TextInputAction.next,
                hint: "UserName",
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextFiled(
                controller: userPasswordController,
                onValidate: (val) {
                  if (val.isEmpty) {
                    return "Please Enter Password";
                  }
                  return null;
                },
                isPassword: true,
                prefix: LineIcons.lock,
                suffix: null,
                hint: "Password",
              ),
              SizedBox(
                height: 40.h,
              ),
              AppButton(
                onClick: () {
                  if (FormKeys.loginFormKey.currentState!.validate()) {
                    context.read<LoaderProvider>().isLoading = true;
                    RequestHelper.post(
                      url: "https://fakestoreapi.com/auth/login",
                      data: {
                        "username": userNameController.text,
                        "password": userPasswordController.text,
                      },
                      networkInterface: NetworkInterface(
                        onSuccess: (data) {
                          String? token = data['token'];
                          if (token != null) {
                            PreferencesManager().pref!.setString(
                                "loginToken", userNameController.text);
                            HomeBase.route.pushReplace(context);
                          }
                          context.read<LoaderProvider>().isLoading = false;
                        },
                        onError: (errorMap) {
                          if (errorMap['status'] == 401) {
                            App.showError(
                                message: errorMap['message'].toString(),
                                context: context);
                          }
                          context.read<LoaderProvider>().isLoading = false;
                        },
                      ),
                    );
                  }
                },
                text: "Login",
                type: ButtonType.primary,
              ),
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
                  SignUpScreen.route.push(context);
                },
                text: "Register with us",
                type: ButtonType.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
