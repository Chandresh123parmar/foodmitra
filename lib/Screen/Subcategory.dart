import 'package:flutter/material.dart';

import '../utils/FoodText.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text(widget.categoryName),
        centerTitle:true,
        actions: [
          // 👉 Cart icon
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text(widget.subItems[index]),
              trailing: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (isAdded) {
                      // remove
                      selectedIndexes.remove(index);
                      CartData.cartItems.remove(widget.subItems[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${widget.subItems[index]} Removed!"),
                        ),
                      );
                    } else {
                      // add
                      selectedIndexes.add(index);
                      CartData.cartItems.add(widget.subItems[index]);
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
                  backgroundColor: isAdded ? Colors.red.shade50 : Colors.blue.shade50,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
