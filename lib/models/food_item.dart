class FoodItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl; // Added image URL for UI

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl, // Require image URL in constructor
  });

  // Equality + hashCode so Map<FoodItem, int> works correctly
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FoodItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
