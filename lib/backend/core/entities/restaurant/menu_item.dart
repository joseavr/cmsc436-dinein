class MenuItem {
  final String id;
  final String restaurantId;

  final String name;
  final String description;
  final String? imageUrl;
  final double price;
  final bool available;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.price,
    required this.available,
  });
}
