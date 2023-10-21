// ignore_for_file: file_names

import 'dart:convert';
import 'package:foodish/Constants/constants.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static Future<List<ProductModel>> getProducts() async {
    try {
      var response =
          await http.get(Uri.parse(Constants.BASE_URL + Constants.Products));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        List<ProductModel> products = [];
        for (Map<String, dynamic> map in data) {
          products.add(ProductModel.fromJson(map));
        }
        return products;
      }
    } catch (e) {
      //throw "Error in loading $e";
      print(e);
    }
    return [];
  }

  static Future<List<Category>> getCategory() async {
    try {
      var response =
          await http.get(Uri.parse(Constants.BASE_URL + Constants.Categories));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        List<Category> categories = [];
        for (Map<String, dynamic> d in data) {
          //print(d);
          categories.add(Category.fromJson(d));
          // print(categories);
        }
        return categories;
      }
    } catch (e) {
      //throw "Error in loading $e";
      print("Error   " + e.toString());
    }
    return [];
  }

  static Future<List<ProductModel>> getCategoryProducts(int id) async {
    try {
      var response = await http.get(Uri.parse(
          "${Constants.BASE_URL}${Constants.Categories}/$id/${Constants.Products}?offset=0&limit=7"));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        List<ProductModel> products = [];
        for (Map<String, dynamic> map in data) {
          products.add(ProductModel.fromJson(map));
        }
        return products;
      }
    } catch (e) {
      //throw "Error in loading $e";
      print(e);
    }
    return [];
  }
}
