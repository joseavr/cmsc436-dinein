import 'package:group_project/backend/core/entities/restaurant/restaurant.dart';
import 'package:group_project/backend/core/entities/user/credit_card.dart';
import 'package:group_project/backend/core/entities/reservation/reservation.dart';

class User {
  // guest properties
  String id;
  String name;
  String email;

  String? phone;
  String? avatarUrl;
  CreditCard? creditcard;
  List<Restaurant>? wishlist;
  List<Reservation>? reservation;

  // owner properties
  bool isOwner;
  Restaurant? ownerRestaurant;

  User({
    // guest properties
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.creditcard,
    this.wishlist,
    this.reservation,

    // owner properties
    this.isOwner = false, // default value false if not provided
    this.ownerRestaurant,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    CreditCard? creditcard,
    List<Restaurant>? wishlist,
    List<Reservation>? reservation,
    bool? isOwner,
    Restaurant? ownerRestaurant,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      creditcard: creditcard ?? this.creditcard,
      wishlist: wishlist ?? List.from(this.wishlist ?? []),
      reservation: reservation ?? List.from(this.reservation ?? []),
      isOwner: isOwner ?? this.isOwner,
      ownerRestaurant: ownerRestaurant ?? this.ownerRestaurant,
    );
  }

  // TODO: add more fields as the app grows
  // In frontend, must check forn nulls
  User copyWithObject(User user) {
    return User(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone ?? phone,
      avatarUrl: user.avatarUrl ?? avatarUrl,
      // credicard: user.credicard ?? credicard,
      // wishlist: user.wishlist ?? List.from(wishlist ?? []),
      // reservation: user.reservation ?? List.from(reservation ?? []),
      // isOwner: user.isOwner ?? isOwner,
      // ownerRestaurant: user.ownerRestaurant ?? ownerRestaurant,
    );
  }
}
