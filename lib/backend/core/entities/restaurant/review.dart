class Review {
  final String id;
  final String restaurantId;
  final String userId;
  final String content;
  final double rating;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.content,
    required this.rating,
    required this.createdAt,
  });
}