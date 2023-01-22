import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/Screens/ProductPage/ProductDetailPage.dart';
import 'package:basicproduct/State/Cart/CartHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCard extends HookWidget {
  final ProductModel item;

  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartHelper = context.read<CartHelper>();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailPage.route,
            arguments: {"data": item},
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: item.image.toString(),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: item.image!,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              item.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(color: Colors.black),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ ${item.price ?? 0}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.rubik(color: Colors.grey),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.grey,
                        size: 12.sp,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "${item.rating!.count ?? 0}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                            color: Colors.black87, fontSize: 10.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
