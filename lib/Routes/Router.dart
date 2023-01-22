import 'package:basicproduct/Screens/Auth/SignUpScreen.dart';
import 'package:basicproduct/Screens/HomeBase.dart';
import 'package:basicproduct/Screens/ProductPage/ProductDetailPage.dart';
import 'package:flutter/material.dart';

import '../Screens/Auth/LoginScreen.dart';
import '../Screens/ProductPage/Cart/CartPage.dart';

class Router {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginScreen(),
        );
      case SignUpScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SignUpScreen(),
        );
      case HomeBase.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeBase(),
        );
      case CartPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CartPage(),
        );
      case ProductDetailPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ProductDetailPage(
            product: settings.arguments == null
                ? null
                : (settings.arguments as Map)['data'],
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
