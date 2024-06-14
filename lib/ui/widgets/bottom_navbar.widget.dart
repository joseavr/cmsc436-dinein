import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/config/icon_assets.dart';
import 'package:group_project/ui/widgets/app_icons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final goRouter = GoRouter.of(context);

    // A listener to listen route changes and its info, through goRouter provider
    return ValueListenableBuilder(
      valueListenable: goRouter.routeInformationProvider,
      builder: (context, RouteInformation? routeInformation, child) {
        String currentTab;
        if (routeInformation?.uri.pathSegments.isEmpty == true) {
          currentTab = 'home';
        } else {
          currentTab = routeInformation?.uri.pathSegments[0] ?? 'home';
        }

        return BottomNavigationBar(
          backgroundColor: colorScheme.background,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.primary.withOpacity(.5),
          showUnselectedLabels: true,
          unselectedFontSize: 14,
          selectedLabelStyle: textTheme.bodySmall,
          unselectedLabelStyle: textTheme.bodySmall,
          currentIndex: _getSelectedIndex(currentTab),
          // selectedIconTheme: ,
          // unselectedIconTheme: ,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _handleNavigation(index, context);
          },
          items: [
            BottomNavigationBarItem(
              icon: AppIcon(
                  iconName: IconAssets.home, color: colorScheme.inversePrimary),
              activeIcon: AppIcon(
                  iconName: IconAssets.home_filled, color: colorScheme.primary),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                  iconName: IconAssets.heart,
                  color: colorScheme.inversePrimary),
              activeIcon: AppIcon(
                  iconName: IconAssets.heart_filled,
                  color: colorScheme.primary),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                  iconName: IconAssets.calendar,
                  color: colorScheme.inversePrimary),
              activeIcon: AppIcon(
                  iconName: IconAssets.calendar_filled,
                  color: colorScheme.primary),
              label: 'Reservations',
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                  iconName: IconAssets.user, color: colorScheme.inversePrimary),
              activeIcon: AppIcon(
                  iconName: IconAssets.user_filled, color: colorScheme.primary),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }

  int _getSelectedIndex(String currentTab) {
    if (currentTab == 'home') {
      return 0;
    } else if (currentTab == 'wishlist') {
      return 1;
    } else if (currentTab == 'reservation') {
      return 2;
    } else if (currentTab == 'profile') {
      return 3;
    }
    return 0; // Default to home if route is not recognized
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/wishlist');
        break;
      case 2:
        context.go('/reservation');
        break;
      case 3:
        context.go('/profile');
        break;
      default:
    }
  }
}
