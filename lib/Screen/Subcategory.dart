import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<String> subItems;

  const SubCategoryScreen({
    super.key,
    required this.categoryName,
    required this.subItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: ListView.builder(
        itemCount: subItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(subItems[index]),
              onTap: () {
                debugPrint("Clicked: ${subItems[index]}");
              },
            ),
          );
        },
      ),
    );
  }
}
