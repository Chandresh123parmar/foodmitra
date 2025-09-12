import 'package:flutter/material.dart';

import '../utils/FoodText.dart';
import '../widget/CartItem.dart';
import 'CartScreen.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryName;
  final List<String> subItems;
  const SubCategoryScreen({
    super.key,
    required this.categoryName,
    required this.subItems,
  });

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();

    // 🔑 Pre-select indexes already in the cart
    for (int i = 0; i < widget.subItems.length; i++) {
      final exists = CartData.cartItems.any((item) =>
      item.categoryName == widget.categoryName &&
          item.subItem == widget.subItems[i]);
      if (exists) {
        selectedIndexes.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.categoryName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(
                    categoryName: '',
                    subItems: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.subItems.length,
        itemBuilder: (context, index) {
          final isAdded = selectedIndexes.contains(index);
          return Card(
            color: isAdded ? Colors.green.shade50 : Colors.white60,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(widget.subItems[index]),
              trailing: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    final cartItem = CartItem(
                      categoryName: widget.categoryName,
                      subItem: widget.subItems[index],
                    );

                    if (isAdded) {
                      selectedIndexes.remove(index);
                      CartData.cartItems.removeWhere((item) =>
                      item.categoryName == widget.categoryName &&
                          item.subItem == widget.subItems[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text("${widget.subItems[index]} Removed!"),
                        ),
                      );
                    } else {
                      selectedIndexes.add(index);
                      CartData.cartItems.add(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${widget.subItems[index]} Added!"),
                        ),
                      );
                    }
                  });
                },
                icon: Icon(
                  isAdded ? Icons.delete_forever : Icons.add,
                  color: isAdded ? Colors.red : Colors.lightBlue,
                ),
                label: Text(
                  isAdded ? "Remove" : "Add",
                  style: TextStyle(
                    color: isAdded ? Colors.red : Colors.lightBlue,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                  isAdded ? Colors.red.shade50 : Colors.blue.shade50,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
