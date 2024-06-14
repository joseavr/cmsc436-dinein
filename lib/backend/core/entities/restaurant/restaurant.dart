import 'package:group_project/backend/core/entities/reservation/reservation.dart';
import 'package:group_project/backend/core/entities/restaurant/food_category.dart';
import 'package:group_project/backend/core/entities/restaurant/menu_item.dart';
import 'package:group_project/backend/core/entities/restaurant/price_range.dart';
import 'package:group_project/backend/core/entities/restaurant/review.dart';
import 'package:group_project/ui/pages/home/opening_hours.dart';

class Restaurant {
  final String id;
  final String?
      ownerId; // some restaurants might be fetched from external apis so they might not have an owner, thus not required
  final String name;
  final double? rating;
  final String? description;
  final String location;
  final String imageUrl;
  final PriceRange? priceRange;
  final FoodCategory category;

  final OpeningHours? openingHours; 
  final String? phone;
  final String? email;

  final List<Review>? reviews;
  final int? reviewsCount;

  final List<MenuItem> menuItems;

  // a restaurant can have many reservations where an user can subscribe to
  final List<Reservation> reservations;

  const Restaurant({
    required this.id,
    this.ownerId,
    required this.name,
    this.rating,
    required this.location,
    this.priceRange,
    required this.imageUrl,
    required this.category,

    //
    this.description,
    this.openingHours,
    this.phone,
    this.email,

    //
    this.reviewsCount,
    this.reviews,

    //
    required this.menuItems,

    //
    this.reservations = const [],
  });
}
