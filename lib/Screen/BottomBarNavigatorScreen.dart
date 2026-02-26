import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmitra/utils/FoodColors.dart';
import 'package:foodmitra/utils/FoodText.dart';

import 'CartScreen.dart';
import 'HomeScreen.dart';
import 'Subcategory.dart';
import 'download_screen.dart';

class Bottombarnavigatorscreen extends StatefulWidget {
  const Bottombarnavigatorscreen({super.key});

  @override
  State<Bottombarnavigatorscreen> createState() =>
      _BottombarnavigatorscreenState();
}

class _BottombarnavigatorscreenState extends State<Bottombarnavigatorscreen> {
  int _currentIndex = 0;

  static const List<Widget> items = [
    HomeScreen(),
    CartScreen(categoryName: '', subItems: []),
  ];

  void ontapmethod(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<String> categories = [
    Biting, Soup, Starter, Sweets, Pulses, Kathiawadi,
    Vegetable_Variety, Punjabi_Variety, Tandoori, Roti, Chinese,
    South_Indian, Farsan, Pizza, Chaat, Raita, Dal, Rice, Salad,
    Chutney, Papad, Lassi, Juice, Cold_Drinks, Water, Thali_Plate,
    Couple, Special_Liquid_Flavor, Special_Liquid_Plaza_Flavor,
    Dry_Fruit_Flavor_in_Pieces, Barfi_Flavor, Live_Sweets, Jamun_Flavor,
    Peda_Flavor, Baklava_Flavor, Ice_Cream_Flavor, Live_Brownie_Lava,
    Ice_Cream_Gola, Special_Candy_Flavor, Pure_Ghee_Flavor,
    Hot_Dry_Fruit_Halwa, Sikhand_Ma_Flavor, Special_Sandesh_Ma_Fruit,
    Matha_Ma_Flavor, Cashew_Almond_Pistachio_Flavor, Matka_Ma_Flavor,
    Cup_Flavor, Sugar_Free_Sweets, Butter_Flavor, Special_Bengali_Flavor,
    Petha_Ma_Flavor,
  ];

  final Map<String, List<String>> categoryMap = {
    Biting: Bitingitem, Soup: Soupitem, Starter: Starteritem,
    Sweets: Sweetsitem, Pulses: Pulsesitem, Kathiawadi: Kathiawadiitem,
    Vegetable_Variety: Vegetable_Varietyitem, Punjabi_Variety: Punjabi_Varietyitem,
    Tandoori: Tandooriitem, Roti: Rotiitem, Chinese: Chineseitem,
    South_Indian: South_Indianitem, Farsan: Farsanitem, Pizza: Pizzaitem,
    Chaat: Chaatitem, Raita: Raitaitem, Dal: Dalitem, Rice: Riceitem,
    Salad: Saladitem, Chutney: Chutneyitem, Papad: Papaditem,
    Lassi: Lassiitem, Juice: Juiceitem, Cold_Drinks: Cold_Drinksitem,
    Water: Wateritem, Thali_Plate: Thali_Plateitem, Couple: Coupleitem,
    Special_Liquid_Flavor: Special_Liquid_Flavoritem,
    Special_Liquid_Plaza_Flavor: Special_Liquid_Plaza_Flavoritem,
    Dry_Fruit_Flavor_in_Pieces: Dry_Fruit_Flavor_in_Piecesitem,
    Barfi_Flavor: Barfi_Flavoritem, Live_Sweets: Live_Sweetsitem,
    Jamun_Flavor: Jamun_Flavoritem, Peda_Flavor: Peda_Flavoritem,
    Baklava_Flavor: Baklava_Flavoritem, Ice_Cream_Flavor: Ice_Cream_Flavoritem,
    Live_Brownie_Lava: Live_Brownie_Lavaitem, Ice_Cream_Gola: Ice_Cream_Golaitem,
    Special_Candy_Flavor: Special_Candy_Flavoritem,
    Pure_Ghee_Flavor: Pure_Ghee_Flavoritem,
    Hot_Dry_Fruit_Halwa: Hot_Dry_Fruit_Halwaitem,
    Sikhand_Ma_Flavor: Sikhand_Ma_Flavoritem,
    Special_Sandesh_Ma_Fruit: Special_Sandesh_Ma_Fruititem,
    Matha_Ma_Flavor: Matha_Ma_Flavoritem,
    Cashew_Almond_Pistachio_Flavor: Cashew_Almond_Pistachio_Flavoritem,
    Matka_Ma_Flavor: Matha_Ma_Flavoritem,
    Cup_Flavor: Cup_Flavoritem, Sugar_Free_Sweets: Sugar_Free_Sweetsitem,
    Butter_Flavor: Butter_Flavoritem,
    Special_Bengali_Flavor: Special_Bengali_Flavoritem,
    Petha_Ma_Flavor: Petha_Ma_Flavoritem,
  };

  String getAppBarTitle() {
    if (_currentIndex == 0) return Category;
    return 'ઓર્ડર';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF2D1600)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              getAppBarTitle(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D1600),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DownloadScreen()));
                  }, value: 'Download',
                    child: Row(
                      children: [
                        Icon(Icons.download_rounded, color: Color(0xFFFF8C42)),
                        SizedBox(width: 5,),
                        Text('Download',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D1600),
                          ),),
                      ],
                    )),
              ]
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFFFE0B2)),
        ),
      ),

      // Drawer
      drawer: Drawer(
        backgroundColor: const Color(0xFFFAF7F2),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 55, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'મહાકાળી કેટરર્સ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${categories.length} Categories',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Category list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      final selectedCategory = categories[index];
                      final subItems = categoryMap[selectedCategory];
                      if (subItems != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubCategoryScreen(
                              categoryName: selectedCategory,
                              subItems: subItems,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8C42).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.restaurant_menu,
                              color: Color(0xFFFF8C42),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              categories[index],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2D1600),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),

      // Bottom nav
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: CupertinoIcons.home,
                  label: 'Home',
                  isActive: _currentIndex == 0,
                  onTap: () => ontapmethod(0),
                ),
                _NavItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'ઓર્ડર',
                  isActive: _currentIndex == 1,
                  onTap: () => ontapmethod(1),
                ),
              ],
            ),
          ),
        ),
      ),

      body: items.elementAt(_currentIndex),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
            colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
          )
              : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey.shade400,
              size: 22,
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}