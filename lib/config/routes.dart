import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/pages/landing/login_page.dart';
import 'package:group_project/ui/pages/landing/signup_page.dart';
import 'package:group_project/ui/pages/home/home_page.dart';
import 'package:group_project/ui/pages/landing/loading_page.dart';
import 'package:group_project/ui/pages/landing/welcome_page.dart';
import 'package:group_project/ui/pages/profile/contact_us_view.dart';
import 'package:group_project/ui/pages/profile/edit_profile_view.dart';
import 'package:group_project/ui/pages/profile/payment_methods_view.dart';
import 'package:group_project/ui/pages/profile/payment_view.dart';
import 'package:group_project/ui/pages/profile/profile_page.dart';
import 'package:group_project/ui/pages/profile/owner_form.dart';
import 'package:group_project/ui/pages/reservation/reservation_page.dart';
import 'package:group_project/ui/pages/wishlist/wishlist_page.dart';
import 'package:group_project/ui/widgets/bottom_navbar.widget.dart';

/// The route configuration.
GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return LoginPage(query: state.uri.queryParameters['email']);
        }),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignUpPage(),
    ),

    // Routes with bottom navbar
    ShellRoute(
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/wishlist',
          name: 'wishlist',
          builder: (context, state) => const WishlistPage(),
        ),
        GoRoute(
          path: '/reservation',
          name: 'reservation',
          builder: (context, state) => const ReservationPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'edit',
              builder: (context, state) => const EditProfileView(),
            ),
            GoRoute(
                path: 'payment',
                name: 'payment',
                builder: (context, state) => const PaymentView(),
                routes: [
                  GoRoute(
                      path: 'methods',
                      name: 'methods',
                      builder: (context, state) => const PaymentMethodView())
                ]),
            GoRoute(
              path: 'contact-us',
              name: 'contact-us',
              builder: (context, state) => const ContactUsView(),
            ),
            GoRoute(
              path: 'owner-form',
              name: 'owner-form',
              builder: (context, state) => const RestaurantForm(),
            ),
          ],
        ),
      ],
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    ),
  ],
);
