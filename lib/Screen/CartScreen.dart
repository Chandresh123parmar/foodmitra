import 'package:flutter/material.dart';
import '../utils/FoodText.dart';
import '../widget/CartItem.dart';
import '../widget/TextWidgets.dart';
import 'BottomBarNavigatorScreen.dart';

class CartScreen extends StatefulWidget {
  final String categoryName;
  final List<String> subItems;
  const CartScreen({super.key, required this.categoryName, required this.subItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // 🔑 Group items by category
    final Map<String, List<CartItem>> groupedItems = {};
    for (var item in CartData.cartItems) {
      groupedItems.putIfAbsent(item.categoryName, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CartData.cartItems.isEmpty
          ? Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Bottombarnavigatorscreen()),
            );
          },
          child: text(
            'Please add items',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.grey.shade500,
          ),
        ),
      )
          : ListView(
        children: groupedItems.entries.map((entry) {
          final category = entry.key;
          final items = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green.shade400),
                  ),
                  child: Center(child: Text(category)),
                ),
              ),
              // Items under this category
              ...items.asMap().entries.map((e) {
                final itemIndex = e.key;
                final item = e.value;
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(item.subItem),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: () {
                            setState(() {
                              CartData.cartItems.remove(item);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
