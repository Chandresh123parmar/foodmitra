import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmitra/utils/FoodColors.dart';
import 'package:foodmitra/utils/FoodText.dart';

import '../widget/TextWidgets.dart';
import 'CartScreen.dart';
import 'HomeScreen.dart';
import 'Subcategory.dart';

class Bottombarnavigatorscreen extends StatefulWidget {
  const Bottombarnavigatorscreen({super.key});

  @override
  State<Bottombarnavigatorscreen> createState() => _BottombarnavigatorscreenState();
}

class _BottombarnavigatorscreenState extends State<Bottombarnavigatorscreen> {

  int _currentIndex = 0;
  int _selectedIndex = 0;

  static const List<Widget> items = [
    HomeScreen(),
    CartScreen(categoryName: '', subItems: [],),
  ];
  void ontapmethod(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  final List<String> categories = [
    Biting,
    Soup,
    Starter,
    Sweets,
    Pulses,
    Kathiawadi,
    Vegetable_Variety,
    Punjabi_Variety,
    Tandoori,
    Roti,
    Chinese,
    South_Indian,
    Farsan,
    Pizza,
    Chaat,
    Raita,
    Dal,
    Rice,
    Salad,
    Chutney,
    Papad,
    Lassi,
    Juice,
    Cold_Drinks,
    Water,
    Thali_Plate,
    Couple,
    Special_Liquid_Flavor,
    Special_Liquid_Plaza_Flavor,
    Dry_Fruit_Flavor_in_Pieces,
    Barfi_Flavor,
    Live_Sweets,
    Jamun_Flavor,
    Peda_Flavor,
    Baklava_Flavor,
    Ice_Cream_Flavor,
    Live_Brownie_Lava,
    Ice_Cream_Gola,
    Special_Candy_Flavor,
    Pure_Ghee_Flavor,
    Hot_Dry_Fruit_Halwa,
    Sikhand_Ma_Flavor,
    Special_Sandesh_Ma_Fruit,
    Matha_Ma_Flavor,
    Cashew_Almond_Pistachio_Flavor,
    Matka_Ma_Flavor,
    Cup_Flavor,
    Sugar_Free_Sweets,
    Butter_Flavor,
    Special_Bengali_Flavor,
    Petha_Ma_Flavor,
  ];
  final Map<String, List<String>> categoryMap = {
    Biting: Bitingitem,
    Soup: Soupitem,
    Starter: Starteritem,
    Sweets: Sweetsitem,
    Pulses: Pulsesitem,
    Kathiawadi: Kathiawadiitem,
    Vegetable_Variety: Vegetable_Varietyitem,
    Punjabi_Variety: Punjabi_Varietyitem,
    Tandoori: Tandooriitem,
    Roti: Rotiitem,
    Chinese: Chineseitem,
    South_Indian: South_Indianitem,
    Farsan: Farsanitem,
    Pizza: Pizzaitem,
    Chaat: Chaatitem,
    Raita: Raitaitem,
    Dal: Dalitem,
    Rice: Riceitem,
    Salad: Saladitem,
    Chutney: Chutneyitem,
    Papad: Papaditem,
    Lassi: Lassiitem,
    Juice: Juiceitem,
    Cold_Drinks: Cold_Drinksitem,
    Water: Wateritem,
    Thali_Plate: Thali_Plateitem,
    Couple: Coupleitem,
    Special_Liquid_Flavor: Special_Liquid_Flavoritem,
    Special_Liquid_Plaza_Flavor: Special_Liquid_Plaza_Flavoritem,
    Dry_Fruit_Flavor_in_Pieces: Dry_Fruit_Flavor_in_Piecesitem,
    Barfi_Flavor: Barfi_Flavoritem,
    Live_Sweets: Live_Sweetsitem,
    Jamun_Flavor: Jamun_Flavoritem,
    Peda_Flavor: Peda_Flavoritem,
    Baklava_Flavor: Baklava_Flavoritem,
    Ice_Cream_Flavor: Ice_Cream_Flavoritem,
    Live_Brownie_Lava: Live_Brownie_Lavaitem,
    Ice_Cream_Gola: Ice_Cream_Golaitem,
    Special_Candy_Flavor: Special_Candy_Flavoritem,
    Pure_Ghee_Flavor: Pure_Ghee_Flavoritem,
    Hot_Dry_Fruit_Halwa: Hot_Dry_Fruit_Halwaitem,
    Sikhand_Ma_Flavor: Sikhand_Ma_Flavoritem,
    Special_Sandesh_Ma_Fruit: Special_Sandesh_Ma_Fruititem,
    Matha_Ma_Flavor: Matha_Ma_Flavoritem,
    Cashew_Almond_Pistachio_Flavor: Cashew_Almond_Pistachio_Flavoritem,
    Matka_Ma_Flavor: Matha_Ma_Flavoritem,
    Cup_Flavor: Cup_Flavoritem,
    Sugar_Free_Sweets: Sugar_Free_Sweetsitem,
    Butter_Flavor: Butter_Flavoritem,
    Special_Bengali_Flavor: Special_Bengali_Flavoritem,
    Petha_Ma_Flavor: Petha_Ma_Flavoritem,
  };

  String getAppBarTitle() {
    String title = "";
    if (_currentIndex == 0) {
      title = Category; // Home title
    } else if (_currentIndex == 1) {
      title = "Cart"; // Cart title
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: text(
            getAppBarTitle(),
            fontSize: 23,
            fontWeight: FontWeight.bold
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount: categories.length,
            itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(),
                  iconSize: 25,
                  alignment: Alignment.centerLeft
                ),
                onPressed: () {
                  debugPrint("Selected: ${categories[index]}");
                  final String selectedCategory = categories[index];
                  final List<String>? subItems = categoryMap[selectedCategory];

                  if (subItems != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SubCategoryScreen(
                          categoryName: selectedCategory,
                          subItems: subItems,
                        ),
                      ),
                    );
                  }else{
                    debugPrint("No Subcategories found for $selectedCategory");
                  }
                },

                icon:Icon(Icons.restaurant_menu,color: Colors.grey.shade600) ,
                label: Text(
                  categories[index],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            }),
      ),

      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Color(customColor('#dce9c5')),
          selectedItemColor: Colors.black,
          selectedFontSize: 15,
          unselectedIconTheme: IconThemeData(
            size: 20
          ),
          selectedIconTheme: IconThemeData(
            size: 25
          ),
          onTap:ontapmethod,
          currentIndex: _currentIndex,
            items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined),label: 'Cart')
        ]),
      ),
      
      body: items.elementAt(_currentIndex),
    );
  }
}
