import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/Utils/Network/RequestHelper.dart';
import 'package:flutter/material.dart';

import '../../Utils/Network/NetworkInterface.dart';

class ProductManager extends ChangeNotifier {
  List<ProductModel> _orignalProductList = [];
  List<ProductModel> _filterProductList = [];
  bool _loader = false;

  bool get loader => _loader;

  set loader(bool value) {
    _loader = value;
    notifyListeners();
  }

  List<ProductModel> get orignalProductList => _orignalProductList;

  set orignalProductList(List<ProductModel> value) {
    _orignalProductList = value;
    notifyListeners();
  }

  List<ProductModel> get filterProductList => _filterProductList;

  set filterProductList(List<ProductModel> value) {
    _filterProductList = value;
    notifyListeners();
  }

  onSearch({String val = ""}) {
    if (val.isEmpty) {
      filterProductList = List.from(orignalProductList);
      return;
    }
    filterProductList = List.from(
      orignalProductList
          .where((element) =>
              element.title!.toLowerCase().contains(val.toLowerCase()))
          .toList(),
    );
  }

  fetchProduct({String category = "All"}) {
    loader = true;
    if (category == "All") {
      RequestHelper.get(
        url: "https://fakestoreapi.com/products",
        networkInterface: NetworkInterface(
          onSuccess: (data) {
            loader = false;
            orignalProductList = [
              ...data.map((e) {
                return ProductModel.fromJson(e);
              })
            ];
            filterProductList = List.from(orignalProductList);
          },
          onError: (errorMap) {
            loader = false;
          },
        ),
      );
    } else {
      RequestHelper.get(
        url: "https://fakestoreapi.com/products/category/$category",
        networkInterface: NetworkInterface(
          onSuccess: (data) {
            loader = false;
            orignalProductList = [
              ...data.map((e) {
                return ProductModel.fromJson(e);
              })
            ];
            filterProductList = List.from(orignalProductList);
          },
          onError: (errorMap) {
            loader = false;
          },
        ),
      );
    }
  }
}
