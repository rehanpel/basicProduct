import 'package:basicproduct/Screens/ProductPage/Cart/CartPage.dart';
import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:basicproduct/Widgets/Buttons/AppButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class ProductDetailPage extends HookWidget {
  static const String route = "/ProductDetailPage";

  final ProductModel? product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartHelper = context.watch<CartHelper>();
    final isInCart = cartHelper.getSingleProductQty(product!.id!.toInt()) == 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
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
        backgroundColor: const Color(0xFF2A63F6),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Product Details",
          style: GoogleFonts.rubik(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  color: Colors.white,
                  child: Hero(
                    tag: product!.image.toString(),
                    child: Center(
                      child: CachedNetworkImage(
                        height: 250,
                        width: 250,
                        imageUrl: product!.image.toString(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListTile(
                  trailing: Chip(
                    backgroundColor: Colors.amber.withOpacity(0.1),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          (product!.rating!.rate ?? 0).toString(),
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    product!.title ?? "",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w600, fontSize: 17.sp),
                  ),
                  subtitle: Text(
                    "\$ ${product!.price ?? 0}",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListTile(
                  title: Text(
                    "Descriptions",
                    style: GoogleFonts.rubik(),
                  ),
                  subtitle: Text(
                    product!.description ?? '',
                    style: GoogleFonts.rubik(),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: AppButton(
              onClick: () async {
                if (isInCart) {
                  if (await Vibration.hasVibrator() ?? false) {
                    Vibration.vibrate(duration: 110, amplitude: -1);
                  }
                  cartHelper.addProduct(product!);
                } else {
                  Navigator.pushNamed(context, CartPage.route);
                }
              },
              type: isInCart ? ButtonType.primary : ButtonType.secondary,
              text: isInCart ? "Add to Cart" : "View Cart",
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
