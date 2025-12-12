// ------------------ HomeScreen.dart ------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/food_item.dart';
import '../data/menu_data.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color mainRed = const Color(0xFFFF4B2B);
  final Color mainPink = const Color(0xFFFF416C);

  // ----------------------------------------------------------
  // SECTION HEADER
  // ----------------------------------------------------------
  Widget _header(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          Text(action,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: mainPink)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F7),
      appBar: _buildAppBar(cartController),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const SizedBox(height: 10),
          _searchBar(),
          const SizedBox(height: 12),
          _bannerSection(),
          const SizedBox(height: 20),
          _categorySection(screenWidth),
          const SizedBox(height: 16),
          _header("Popular Dishes", "View All"),
          _responsiveMenuGrid(MenuData.menuItems.take(6).toList(), cartController, screenWidth),
          const SizedBox(height: 16),
          _header("Chef's Recommendation", "View All"),
          _recommendationList(MenuData.menuItems, cartController, screenWidth),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // APP BAR
  // ----------------------------------------------------------
  AppBar _buildAppBar(CartController cartController) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.black12,
      title: Row(
        children: [
          Image.asset("assets/logo.png", height: 32),
          const SizedBox(width: 8),
          Text(
            "Foodie",
            style: TextStyle(
              color: mainRed,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite, color: mainPink),
          onPressed: () {
            if (cartController.favorites.isEmpty) {
              Get.snackbar(
                "Favorites",
                "You have no favorite dishes yet!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                colorText: Colors.black87,
              );
            } else {
              Get.to(() => FavoritesScreen());
            }
          },
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: mainRed),
              onPressed: () => Get.toNamed("/cart"),
            ),
            Positioned(
              right: 2,
              top: 6,
              child: Obx(() {
                int count = cartController.totalItems;
                return count == 0
                    ? const SizedBox.shrink()
                    : Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: mainPink,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "$count",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ----------------------------------------------------------
  // SEARCH BAR
  // ----------------------------------------------------------
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: mainPink.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: mainRed.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey),
            hintText: "Search meals...",
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // BANNER SECTION
  // ----------------------------------------------------------
  Widget _bannerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [mainRed, mainPink]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Get Up To 20% Discount On",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Your First Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset("assets/chef1.jpg"),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CATEGORY SECTION
  // ----------------------------------------------------------
  Widget _categorySection(double screenWidth) {
    final categories = [
      {"icon": Icons.fastfood, "label": "Burger"},
      {"icon": Icons.local_drink, "label": "Beverage"},
      {"icon": Icons.set_meal, "label": "Seafood"},
      {"icon": Icons.local_pizza, "label": "Pizza"},
      {"icon": Icons.set_meal, "label": "Chicken"},
      {"icon": Icons.icecream, "label": "Dessert"},
    ];

    double boxWidth = screenWidth > 600
        ? (screenWidth - 32 - (categories.length - 1) * 12) / categories.length
        : 80;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final cat = categories[index];
          return Container(
            width: boxWidth,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat["icon"] as IconData, color: mainRed, size: 32),
                const SizedBox(height: 6),
                Text(
                  cat["label"] as String,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // RESPONSIVE MENU GRID
  // ----------------------------------------------------------
  Widget _responsiveMenuGrid(
      List<FoodItem> items, CartController controller, double screenWidth) {
    int crossAxisCount = screenWidth > 800 ? 3 : 1;
    double itemWidth = (screenWidth - 32 - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: itemWidth / 230,
        ),
        itemBuilder: (_, index) =>
            _buildMenuCard(items[index], controller, width: itemWidth),
      ),
    );
  }

  // ----------------------------------------------------------
  // CHEF'S RECOMMENDATION LIST
  // ----------------------------------------------------------
  Widget _recommendationList(
      List<FoodItem> items, CartController controller, double screenWidth) {
    double cardWidth = screenWidth > 600 ? 200 : 160;
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final item = items[index];
          return Container(
            width: cardWidth,
            decoration: _cardStyle(),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(item.imageUrl,
                        width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "\$${item.price}",
                    style: TextStyle(
                        color: mainRed, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                _addButton(item, controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard(FoodItem item, CartController controller,
      {double width = 170}) {
    return Container(
      width: width,
      decoration: _cardStyle(),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(item.imageUrl,
                      width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    return InkWell(
                      onTap: () => controller.toggleFavorite(item),
                      child: Icon(
                        controller.isFavorite(item)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "\$${item.price}",
              style: TextStyle(
                  color: mainRed, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          _addButton(item, controller),
        ],
      ),
    );
  }

  Widget _addButton(FoodItem item, CartController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: InkWell(
        onTap: () => controller.addToCart(item),
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [mainRed, mainPink]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text("Add",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )
      ],
    );
  }
}
