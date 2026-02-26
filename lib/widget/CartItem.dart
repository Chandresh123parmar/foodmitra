import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String categoryName;
  final String subItem;

  CartItem({required this.categoryName, required this.subItem});

  // JSON માં convert કરો (save માટે)
  Map<String, dynamic> toJson() => {
    'categoryName': categoryName,
    'subItem': subItem,
  };

  // JSON માંથી CartItem બનાવો (load માટે)
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    categoryName: json['categoryName'],
    subItem: json['subItem'],
  );
}

class CartData {
  static List<CartItem> cartItems = [];
  static const _key = 'cart_items';

  /// App start થાય ત્યારે SharedPreferences માંથી load કરો
  static Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      cartItems = decoded.map((e) => CartItem.fromJson(e)).toList();
    }
  }

  /// Item ઉમેર્યા/દૂર કર્યા પછી save કરો
  static Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(cartItems.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  /// Cart clear કરો (save સાથે)
  static Future<void> clearCart() async {
    cartItems.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_items'); // તમારી key અહીં મૂકો
  }
}