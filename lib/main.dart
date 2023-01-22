import 'package:basicproduct/Screens/Auth/LoginScreen.dart';
import 'package:basicproduct/State/Auth/Authentication.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:basicproduct/State/ProductManager/ProductManager.dart';
import 'package:basicproduct/Utils/Loader/LoaderProvider.dart';
import 'package:basicproduct/Utils/Loader/LoaderWrapper.dart';
import 'package:basicproduct/Utils/PreferencesManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './Routes/Router.dart' as r;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initUtils();
  runApp(const MyApp());
}

initUtils() async {
  PreferencesManager().init(onComplete: () {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(
          create: (context) => Authentication(),
        ),
        ChangeNotifierProvider<LoaderProvider>(
          create: (context) => LoaderProvider(),
        ),
        ChangeNotifierProvider<CartHelper>(
          create: (context) => CartHelper(),
        ),
        ChangeNotifierProvider<ProductManager>(
          create: (context) => ProductManager(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const LoaderWrapper(
            child: MaterialApp(
              title: "Product Demo",
              initialRoute: LoginScreen.route,
              onGenerateRoute: r.Router.onGenerateRoute,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
