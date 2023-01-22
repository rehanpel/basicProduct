import 'dart:convert';

import 'package:basicproduct/Database/DatabaseHelper.dart';
import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:basicproduct/Widgets/Buttons/AppButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {
  static const String route = "/CartPage";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartHelper = context.watch<CartHelper>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A63F6),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Cart",
          style: GoogleFonts.rubik(color: Colors.white),
        ),
      ),
      body: cartHelper.cart.isEmpty
          ? SizedBox(
              width: 100.sw,
              height: 100.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  SvgPicture.asset(
                    "assets/empty.svg",
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "No Item Added in cart",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  AppButton(
                    onClick: () {
                      Navigator.pop(context);
                    },
                    text: "Shop Now",
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                Map item = cartHelper.cart[index];
                ProductModel product = ProductModel.fromJson(
                  json.decode(
                    item[DatabaseHelper.columnDetails],
                  ),
                );
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 3.0,
                        spreadRadius: 3.0,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (item[DatabaseHelper.columnQty] > 1) {
                              cartHelper.updateProductQty(item, isAdd: false);
                            } else {
                              cartHelper.delete(item[DatabaseHelper.columnId]);
                            }
                          },
                          icon: Text(
                            "-",
                            style: GoogleFonts.rubik(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cartHelper.addProduct(product);
                          },
                          icon: Text(
                            "+",
                            style: GoogleFonts.rubik(),
                          ),
                        ),
                      ],
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.image.toString(),
                        width: 40,
                        height: 40,
                      ),
                    ),
                    title: Text(
                      product.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "Qty :${item[DatabaseHelper.columnQty]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: cartHelper.cart.length,
            ),
    );
  }
}
