import 'package:basicproduct/Screens/ProductPage/Cart/CartPage.dart';
import 'package:basicproduct/Screens/ProductPage/ProductListWidget.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:basicproduct/State/ProductManager/ProductManager.dart';
import 'package:basicproduct/Utils/PreferencesManager.dart';
import 'package:basicproduct/Widgets/Category/ChipCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeBase extends HookWidget {
  static const String route = "/HomeBase";

  const HomeBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartHelper = context.watch<CartHelper>();
    final selectedCategory = useState<String>("All");
    final isSearch = useState<bool>(false);
    final productManager = context.watch<ProductManager>();


    useEffect(() {
      cartHelper.getAllProduct();
      return (){};
    },[]);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2A63F6),
                    const Color(0xFF2A63F6).withOpacity(0.85),
                  ],
                ),
              ),
              child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ListTile(
                          title: Text(
                            "Product Demo",
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          subtitle: Text(
                            "by RehanAbbas",
                            style: GoogleFonts.rubik(
                              color: Colors.white.withOpacity(0.45),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, CartPage.route);
                    },
                    trailing: CircleAvatar(
                      radius: 9.sp,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartHelper.cart.length.toString(),
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black87,
                    ),
                    title: Text(
                      "Cart",
                      style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      PreferencesManager().pref?.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/", (route) => false);
                    },
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.black87,
                    ),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    "",
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                  subtitle: Text(
                    "Version 1.0.0",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: Colors.black.withOpacity(0.45),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2A63F6),
        centerTitle: false,
        title: isSearch.value
            ? TextFormField(
                onChanged: (value) {
                  productManager.onSearch(val: value);
                },
                style: GoogleFonts.rubik(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Product",
                  hintStyle: GoogleFonts.rubik(
                    color: Colors.white30,
                  ),
                ),
              )
            : Text(
                "Products",
                style: GoogleFonts.rubik(
                  color: Colors.white,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              isSearch.value = !isSearch.value;
            },
            icon: Icon(
              isSearch.value ? Icons.clear : Icons.search,
              color: Colors.white,
            ),
          ),
          isSearch.value
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartPage.route);
                  },
                  icon: Stack(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 6.sp,
                          backgroundColor: Colors.red,
                          child: Text(
                            cartHelper.cart.length.toString(),
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 7.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
      body: Column(
        children: [
          ChipCategory(
            selected: selectedCategory.value,
            onSelect: (value) {
              selectedCategory.value = value;
            },
          ),
          Expanded(
            child: ProductListWidget(
              category: selectedCategory.value,
            ),
          ),
        ],
      ),
    );
  }
}
