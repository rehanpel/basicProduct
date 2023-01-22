import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductLoader extends HookWidget {
  const ProductLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(5.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: FadeShimmer(
                    height: 200,
                    width: 200,
                    radius: 4,
                    highlightColor: Colors.grey.withOpacity(0.3),
                    baseColor: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeShimmer(
                height: 10,
                width: 200.w,
                radius: 4,
                highlightColor: Colors.grey.withOpacity(0.3),
                baseColor: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeShimmer(
                height: 10,
                width: 100.w,
                radius: 4,
                highlightColor: Colors.grey.withOpacity(0.3),
                baseColor: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
        );
      },
    );
  }
}
