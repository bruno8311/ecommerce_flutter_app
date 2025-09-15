import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_item_model.dart';

class LocalStorage {
  static const String key = 'products';

  // Obtener productos desde SharedPreferences
  Future<List<ProductItemModel>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsString = prefs.getString(key);
    if (productsString != null) {
      final productsJson = jsonDecode(productsString) as List;
      return productsJson.map((e) => ProductItemModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return [];
  }

  // Guardar productos en SharedPreferences
  Future<void> saveProducts(List<ProductItemModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products.map((e) => e.toJson()).toList();
    await prefs.setString(key, jsonEncode(productsJson));
  }
}