import 'dart:convert';

import 'package:basicproduct/Database/DatabaseHelper.dart';
import 'package:basicproduct/Screens/ProductPage/Model/ProductModel.dart';
import 'package:basicproduct/Utils/PreferencesManager.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CartHelper extends ChangeNotifier {
  List<Map> _cart = [];

  List<Map> get cart => _cart;

  set cart(List<Map> value) {
    _cart = value;
    notifyListeners();
  }

  addProduct(ProductModel model) async {
    Database? db = await DatabaseHelper.instance.database;
    Map? p = await getSingleProduct(model.id!.toInt());
    if (p != null) {
      updateProductQty(p);
    } else {
      if (db != null) {
        int p = await db.insert(DatabaseHelper.table, {
          DatabaseHelper.columnUserId:
              PreferencesManager().pref?.getString("loginToken"),
          DatabaseHelper.columnDetails: json.encode(model.toJson()),
          DatabaseHelper.columnProductId: model.id!.toInt(),
          DatabaseHelper.columnQty: 1,
          DatabaseHelper.columnDate: DateTime.now().toString(),
        });
        getAllProduct();
        print("Inserted =========> $p");
      }
    }
  }

  delete(int id) async {
    Database? db = await DatabaseHelper.instance.database;

    String whereString =
        '${DatabaseHelper.columnUserId} = ? and ${DatabaseHelper.columnId} = ?';
    List<dynamic> whereArguments = [
      PreferencesManager().pref?.getString("loginToken"),
      id
    ];
    db?.delete(
      DatabaseHelper.table,
      where: whereString,
      whereArgs: whereArguments,
    );
    getAllProduct();
  }

  updateProductQty(Map previousProduct, {bool isAdd = true}) async {
    Database? db = await DatabaseHelper.instance.database;
    if (previousProduct[DatabaseHelper.columnQty] <= 0) {
      print("Quantity is Less than Zero");
      return;
    }
    Map<String, dynamic> data = {
      DatabaseHelper.columnProductId:
          previousProduct[DatabaseHelper.columnProductId],
      DatabaseHelper.columnQty: isAdd
          ? previousProduct[DatabaseHelper.columnQty] + 1
          : previousProduct[DatabaseHelper.columnQty] - 1,
      DatabaseHelper.columnDetails:
          previousProduct[DatabaseHelper.columnDetails],
      DatabaseHelper.columnDate: previousProduct[DatabaseHelper.columnDate],
      DatabaseHelper.columnUserId: previousProduct[DatabaseHelper.columnUserId],
    };
    String whereString =
        '${DatabaseHelper.columnUserId} = ? and ${DatabaseHelper.columnId} = ?';
    List<dynamic> whereArguments = [
      PreferencesManager().pref?.getString("loginToken"),
      previousProduct[DatabaseHelper.columnId]
    ];
    db?.update(
      DatabaseHelper.table,
      data,
      where: whereString,
      whereArgs: whereArguments,
    );
    getAllProduct();
  }

  int getSingleProductQty(int id) {
    List temp = cart
        .where(
          (element) =>
              json
                  .decode(element[DatabaseHelper.columnDetails])['id']
                  .toString() ==
              id.toString(),
        )
        .toList();
    if (temp.isNotEmpty) {
      return temp[0][DatabaseHelper.columnQty];
    }
    return 0;
  }

  Future<Map?> getSingleProduct(int productId) async {
    Database? db = await DatabaseHelper.instance.database;
    String whereString =
        '${DatabaseHelper.columnUserId} = ? and ${DatabaseHelper.columnProductId} = ?';
    List<dynamic> whereArguments = [
      PreferencesManager().pref?.getString("loginToken"),
      productId
    ];
    // get all rows
    List temp = await db?.query(
          DatabaseHelper.table,
          where: whereString,
          whereArgs: whereArguments,
        ) ??
        [];
    if (temp.isNotEmpty) {
      return temp[0];
    }

    return null;
  }

  getAllProduct() async {
    Database? db = await DatabaseHelper.instance.database;
    String whereString = '${DatabaseHelper.columnUserId} = ? ';
    List<dynamic> whereArguments = [
      PreferencesManager().pref?.getString("loginToken"),
    ];
    // get all rows
    cart = await db?.query(
          DatabaseHelper.table,
          where: whereString,
          whereArgs: whereArguments,
        ) ??
        [];
  }
}
