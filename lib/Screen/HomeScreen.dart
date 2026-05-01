// HomeScreen.dart - UPDATED with English+Gujarati Search

import 'package:flutter/material.dart';
import 'package:foodmitra/Screen/Subcategory.dart';
import '../utils/FoodText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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

  // ✅ English aliases for Gujarati categories (for English search support)
  final Map<String, List<String>> categoryEnglishAliases = {
    'બાઇટિંગ': ['biting', 'snack', 'bite'],
    'સૂપ': ['soup', 'shorba'],
    'સ્ટાર્ટર': ['starter', 'appetizer', 'start'],
    'મીઠાઈ': ['sweets', 'mithai', 'sweet', 'dessert', 'meethai'],
    'કઠોળ': ['pulses', 'dal', 'beans', 'lentils'],
    'કાઠિયાવાડી': ['kathiawadi', 'kathiyawadi', 'gujarati'],
    'વેજીટેબલ વેરિયેટી': ['vegetable', 'sabji', 'sabzi', 'veggies', 'variety'],
    'પંજાબી વેરિયેટી': ['punjabi', 'north indian'],
    'ટંડૂરી': ['tandoori', 'tandoor', 'grilled'],
    'રોટલી': ['roti', 'bread', 'chapati', 'paratha', 'rotli'],
    'ચાઇનીઝ': ['chinese', 'noodles', 'china'],
    'સાઉથ ઇન્ડિયન': ['south indian', 'idli', 'dosa', 'sambhar'],
    'ફરસાણ': ['farsan', 'namkeen', 'snacks', 'farsaan'],
    'પિઝ્ઝા': ['pizza', 'piza'],
    'ચાટ': ['chaat', 'chat', 'bhel', 'pav bhaji', 'puchka'],
    'રાયતા': ['raita', 'rayta', 'curd', 'yogurt'],
    'દાળ': ['dal', 'daal', 'lentil'],
    'ભાત': ['rice', 'bhat', 'biryani', 'pulao'],
    'સલાડ': ['salad', 'salads'],
    'ચટણી': ['chutney', 'chatni', 'sauce', 'dip'],
    'પાપડ': ['papad', 'papadum', 'pappad'],
    'લસ્સી': ['lassi', 'lasi', 'buttermilk', 'chhach'],
    'જ્યૂસ': ['juice', 'jus', 'fresh juice'],
    'ઠંડા પીણા': ['cold drinks', 'cold drink', 'soda', 'beverage', 'drinks', 'thanda'],
    'પાણી': ['water', 'paani'],
    'થાળી/પ્લેટ': ['thali', 'plate', 'thali plate', 'meal', 'thaali'],
    'કપલ': ['couple', 'couples'],
    'સ્પેશ્યલ લિક્વિડ ફ્લેવર': ['special liquid', 'liquid flavor', 'flavour'],
    'સ્પેશ્યલ લિક્વિડ પ્લાઝા ફ્લેવર': ['plaza flavor', 'liquid plaza'],
    'ડ્રાય ફ્રૂટ ફ્લેવર ઈન પીસ': ['dry fruit', 'dryfruit', 'kaju', 'badam', 'pista', 'pieces'],
    'બર્ફી ફ્લેવર': ['barfi', 'barfi flavor', 'burfi'],
    'લાઇવ સ્વિટ્સ': ['live sweets', 'fresh sweets'],
    'જામુન ફ્લેવર': ['jamun', 'gulab jamun', 'jamoon'],
    'પેડા ફ્લેવર': ['peda', 'pedha', 'penda'],
    'બક્લાવા ફ્લેવર': ['baklava', 'baklawa'],
    'આઈસ ક્રીમ ફ્લેવર': ['ice cream', 'icecream', 'gelato'],
    'લાઇવ બ્રાઉની લાવા': ['brownie', 'lava', 'brownie lava'],
    'આઈ.ક્રીમ.ગોળ': ['ice cream gola', 'gola', 'kulfi'],
    'સ્પેશ્યલ કૅન્ડી ફ્લેવર': ['candy', 'special candy', 'toffee'],
    'પ્યોર ઘી ફ્લેવર': ['pure ghee', 'ghee', 'desi ghee'],
    'હોટ ડ્રાઇ ફ્રૂટ હલ્વો': ['halwa', 'halva', 'hot halwa', 'dry fruit halwa'],
    'શ્રીખંડ મ.ફ.': ['shrikhand', 'srikhand', 'shreekhnad', 'sikhand'],
    'સ્પેશ્યલ સંદેશ મ.ફ.': ['sandesh', 'sandesh fruit', 'bengali sweet'],
    'માઠ મ.ફ.': ['matha', 'math', 'matha flavor'],
    'કાજૂ.બ.પ.ફ.': ['cashew', 'almond', 'pistachio', 'kaju', 'badam'],
    'માટકા મ.ફ.': ['matka', 'earthen pot', 'matka flavor'],
    'કપ ફ્લેવર': ['cup', 'cup flavor'],
    'સુગર ફ્રી સ્વિટ્સ': ['sugar free', 'sugarfree', 'diabetic', 'no sugar'],
    'બટર ફ્લેવર': ['butter', 'butter flavor'],
    'સ્પેશ્યલ બંગાળી ફ્લેવર': ['bengali', 'bengali flavor', 'bengali sweet'],
    'પેઠા મ.ફ.': ['petha', 'petta', 'petha flavor'],
  };

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

  final Map<String, IconData> categoryIcons = {
    'બાઇટિંગ': Icons.lunch_dining,
    'સૂપ': Icons.soup_kitchen,
    'સ્ટાર્ટર': Icons.restaurant,
    'મીઠાઈ': Icons.cake,
    'કઠોળ': Icons.grass,
    'કાઠિયાવાડી': Icons.rice_bowl,
    'વેજીટેબલ વેરિયેટી': Icons.eco,
    'પંજાબી વેરિયેટી': Icons.local_dining,
    'ટંડૂરી': Icons.whatshot,
    'રોટલી': Icons.breakfast_dining,
    'ચાઇનીઝ': Icons.ramen_dining,
    'સાઉથ ઇન્ડિયન': Icons.brunch_dining,
    'ફરસાણ': Icons.fastfood,
    'પિઝ્ઝા': Icons.local_pizza,
    'ચાટ': Icons.tapas,
    'રાયતા': Icons.set_meal,
    'દાળ': Icons.soup_kitchen,
    'ભાત': Icons.rice_bowl,
    'સલાડ': Icons.spa,
    'ચટણી': Icons.sports_bar,
    'પાપડ': Icons.circle_outlined,
    'લસ્સી': Icons.local_drink,
    'જ્યૂસ': Icons.emoji_food_beverage,
    'ઠંડા પીણા': Icons.local_bar,
    'પાણી': Icons.water_drop,
    'થાળી/પ્લેટ': Icons.dinner_dining,
    'કપલ': Icons.favorite,
  };

  final List<Color> _cardColors = [
    const Color(0xFFFFF3E0), const Color(0xFFE8F5E9),
    const Color(0xFFE3F2FD), const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5), const Color(0xFFE0F7FA),
    const Color(0xFFFFF8E1), const Color(0xFFE8EAF6),
  ];

  final List<Color> _iconColors = [
    const Color(0xFFFF8C42), const Color(0xFF4CAF50),
    const Color(0xFF2196F3), const Color(0xFFE91E63),
    const Color(0xFF9C27B0), const Color(0xFF00BCD4),
    const Color(0xFFFFC107), const Color(0xFF3F51B5),
  ];

  // ✅ Main search function - Gujarati + English both supported
  bool _matchesSearch(String category) {
    if (_searchQuery.isEmpty) return true;
    final query = _searchQuery.toLowerCase().trim();

    // 1. Gujarati category name match
    if (category.toLowerCase().contains(query)) return true;

    // 2. English alias match for category
    final aliases = categoryEnglishAliases[category] ?? [];
    if (aliases.any((alias) => alias.contains(query) || query.contains(alias))) return true;

    // 3. Subcategory item match (Gujarati)
    final subItems = categoryMap[category] ?? [];
    if (subItems.any((item) => item.toLowerCase().contains(query))) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Filter using new search function
    final filtered = categories.where(_matchesSearch).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF7F2),
        body: Column(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(fontSize: 15, color: Color(0xFF3D1C00)),
                decoration: InputDecoration(
                  hintText: CategorySearch, // "કેટેગરી / Item શોધો..."
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFF8C42), size: 22),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            // Grid
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off, size: 60, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      'કોઈ કેટેગરી મળી નથી',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Try searching in English or Gujarati',
                      style: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.fromLTRB(7, 4, 7, 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.4,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final colorIdx = index % _cardColors.length;
                  final bgColor = _cardColors[colorIdx];
                  final iconColor = _iconColors[colorIdx];
                  final icon = categoryIcons[filtered[index]] ?? Icons.restaurant_menu;
                  final itemCount = categoryMap[filtered[index]]?.length ?? 0;

                  return GestureDetector(
                    onTap: () {
                      final selectedCategory = filtered[index];
                      final allItems = categoryMap[selectedCategory] ?? [];

                      // ✅ When navigating, show filtered items if search is active
                      final filteredItems = _searchQuery.isEmpty
                          ? allItems
                          : allItems
                          .where((item) => item
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                          .toList();

                      // If no subcategory matched but category matched, show all items
                      final itemsToShow = filteredItems.isEmpty ? allItems : filteredItems;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubCategoryScreen(
                            categoryName: selectedCategory,
                            subItems: itemsToShow,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: iconColor.withOpacity(0.2),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: iconColor.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(icon, color: iconColor, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filtered[index],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2D1600),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (itemCount > 0)
                                  Text(
                                    '$itemCount items',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: iconColor.withOpacity(0.6),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}