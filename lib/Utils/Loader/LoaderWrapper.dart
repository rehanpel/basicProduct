import 'package:basicproduct/Utils/Loader/LoaderProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoaderWrapper extends StatelessWidget {
  final Widget child;

  const LoaderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loader = context.watch<LoaderProvider>();
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            child,
            loader.isLoading
                ? Container(
                    height: 100.sh,
                    width: 100.sw,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
