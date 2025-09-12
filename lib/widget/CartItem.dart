class CartItem {
  final String categoryName;
  final String subItem;

  CartItem({required this.categoryName, required this.subItem});
}

class CartData {
  static List<CartItem> cartItems = [];
}