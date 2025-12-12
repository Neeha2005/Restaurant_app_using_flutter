import 'package:get/get.dart';
import '../models/food_item.dart';

class CartController extends GetxController {
  var cartItems = <FoodItem, int>{}.obs;

  // Add favorites
  var favorites = <FoodItem>[].obs;

  void addToCart(FoodItem item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    } else {
      cartItems[item] = 1;
    }
  }

  void removeFromCart(FoodItem item) {
    if (!cartItems.containsKey(item)) return;

    if (cartItems[item]! > 1) {
      cartItems[item] = cartItems[item]! - 1;
    } else {
      cartItems.remove(item);
    }
  }

  double get totalPrice {
    double total = 0.0;
    cartItems.forEach((item, qty) {
      total += item.price * qty;
    });
    return total;
  }

  int get totalItems => cartItems.values.fold(0, (sum, qty) => sum + qty);

  void toggleFavorite(FoodItem item) {
    if (favorites.contains(item)) {
      favorites.remove(item);
    } else {
      favorites.add(item);
    }
  }

  bool isFavorite(FoodItem item) {
    return favorites.contains(item);
  }

  void clearCart() {
    cartItems.clear();
  }
}
