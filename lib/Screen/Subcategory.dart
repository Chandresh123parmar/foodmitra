import 'package:flutter/material.dart';

import '../utils/FoodText.dart';
import '../widget/CartItem.dart';

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
  int get addedCount => selectedIndexes.length;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.subItems.length; i++) {
      final exists = CartData.cartItems.any((item) =>
      item.categoryName == widget.categoryName &&
          item.subItem == widget.subItems[i]);
      if (exists) selectedIndexes.add(i);
    }
  }

  void _toggleItem(int index) {
    setState(() {
      final cartItem = CartItem(
        categoryName: widget.categoryName,
        subItem: widget.subItems[index],
      );

      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
        CartData.cartItems.removeWhere((item) =>
        item.categoryName == widget.categoryName &&
            item.subItem == widget.subItems[index]);
        _showSnack('${widget.subItems[index]} દૂર કર્યું', isAdded: false);
      } else {
        selectedIndexes.add(index);
        CartData.cartItems.add(cartItem);
        _showSnack('${widget.subItems[index]} ઉમેર્યું!', isAdded: true);
      }
    });
    CartData.saveCart();
  }

  void _showSnack(String message, {required bool isAdded}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isAdded ? Icons.check_circle : Icons.remove_circle,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message, style: const TextStyle(fontSize: 13))),
          ],
        ),
        backgroundColor: isAdded ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFFFF8C42)),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.categoryName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D1600),
              ),
            ),
            Text(
              '${widget.subItems.length} items',
              style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFFFE0B2)),
        ),
      ),
      body: Column(
        children: [
          // Selected count banner
          if (addedCount > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    '$addedCount item${addedCount > 1 ? 's' : ''} selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(14),
              itemCount: widget.subItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final isAdded = selectedIndexes.contains(index);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: isAdded ? const Color(0xFFE8F5E9) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isAdded
                          ? const Color(0xFF4CAF50).withOpacity(0.5)
                          : const Color(0xFFFFE0B2),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: isAdded
                          ? const Color(0xFF4CAF50).withOpacity(0.12)
                          : const Color(0xFFFF8C42).withOpacity(0.1),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isAdded ? const Color(0xFF2E7D32) : const Color(0xFFFF8C42),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.subItems[index],
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: isAdded ? FontWeight.w700 : FontWeight.w500,
                        color: isAdded ? const Color(0xFF1B5E20) : const Color(0xFF2D1600),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => _toggleItem(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: isAdded
                              ? const LinearGradient(
                            colors: [Color(0xFFFFEBEE), Color(0xFFFCE4EC)],
                          )
                              : const LinearGradient(
                            colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: isAdded
                                  ? Colors.red.withOpacity(0.15)
                                  : const Color(0xFFFF8C42).withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isAdded ? Icons.remove : Icons.add,
                              size: 14,
                              color: isAdded ? const Color(0xFFE53935) : Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isAdded ? 'Remove' : 'Add',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isAdded ? const Color(0xFFE53935) : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}