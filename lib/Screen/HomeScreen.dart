import 'package:flutter/material.dart';
import 'package:foodmitra/Screen/Subcategory.dart';
import '../utils/FoodText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController SearchBar = TextEditingController();

  // List of all food category texts
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

  @override
  Widget build(BuildContext context) {
    // final widgetWidth = MediaQuery.of(context).size.width / 2.1;
    // final height = MediaQuery.of(context).size.height / 15;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(Category),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: SearchBar,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  hintText: CategorySearch,
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Selected: ${categories[index]}");
                        final String selectedCategory = categories[index];
                        final List<String>? subItems =
                            categoryMap[selectedCategory];

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
                      child: Text(
                        categories[index],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
