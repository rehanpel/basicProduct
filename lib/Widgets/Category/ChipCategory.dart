import 'package:basicproduct/Utils/Network/NetworkInterface.dart';
import 'package:basicproduct/Utils/Network/RequestHelper.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipCategory extends HookWidget {
  final Function(String value) onSelect;
  final String selected;

  const ChipCategory({Key? key, required this.onSelect, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = useState<List>([]);
    final loader = useState<bool>(false);

    fetchCategory() {
      loader.value = true;
      RequestHelper.get(
        url: "https://fakestoreapi.com/products/categories",
        networkInterface: NetworkInterface(
          onSuccess: (data) {
            loader.value = false;
            category.value = ["All", ...data];
          },
          onError: (errorMap) {
            print(errorMap);
            loader.value = false;
          },
        ),
      );
    }

    useEffect(() {
      fetchCategory();
      return () {};
    }, []);

    return loader.value
        ? Row(
            children: [
              ...List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  child: FadeShimmer(
                    height: 30.h,
                    width: 100.w,
                    millisecondsDelay: 200,
                    fadeTheme: FadeTheme.light,
                    radius: 100,
                    highlightColor: Colors.grey,
                    baseColor: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: 30.h,
            margin: EdgeInsets.only(
              top: 10.h,
              left: 5.w,
              right: 5.w,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...category.value.map((e) {
                  bool isSelected = selected == e;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ),
                    child: InkWell(
                      onTap: () async {

                        onSelect(e);
                      },
                      child: Chip(
                        elevation: 0,
                        backgroundColor: isSelected
                            ? const Color(0xFF2A63F6)
                            : Colors.grey.withOpacity(
                                0.15,
                              ),
                        label: Text(
                          e,
                          style: GoogleFonts.rubik(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          );
  }
}
