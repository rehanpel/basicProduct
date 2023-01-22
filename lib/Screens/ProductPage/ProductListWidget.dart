import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/Screens/ProductPage/Widget/ProductCard.dart';
import 'package:basicproduct/Screens/ProductPage/Widget/ProductLoader.dart';
import 'package:basicproduct/Utils/Network/RequestHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../State/ProductManager/ProductManager.dart';
import '../../Utils/Network/NetworkInterface.dart';

class ProductListWidget extends HookWidget {
  final String category;

  const ProductListWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productManager = context.watch<ProductManager>();

    useEffect(() {
      Future.microtask(() => productManager.fetchProduct(category: category));
      return () {};
    }, [category]);

    return productManager.loader
        ? const ProductLoader()
        : SafeArea(
            top: false,
            child: GridView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: productManager.filterProductList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (context, index) {
                ProductModel item = productManager.filterProductList[index];
                return ProductCard(
                  item: item,
                );
              },
            ),
          );
  }
}
