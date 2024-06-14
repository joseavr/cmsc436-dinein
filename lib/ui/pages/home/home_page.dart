import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List _foundRestanrants = [];
  List _restaurantsFiltered = [];

  @override
  initState() {
    super.initState();
    fetchRestaurants();
  }

  Future fetchRestaurants() async {
    try {
      final response = await Supabase.instance.client
          .from('restaurants')
          .select('*, food_categories(*), reviews(*, users(*)), menu_items(*)');

      setState(() => _foundRestanrants = response);
      setState(() => _restaurantsFiltered = response);
    } on Exception catch (e) {
      if (mounted) {
        showKwunSnackBar(context: context, message: e.toString());
      }
    }
  }

  void _runFilter(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = _foundRestanrants;
    } else {
      results = _foundRestanrants
          .where((res) => res["restaurant_name"]
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _restaurantsFiltered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    double appPadding = 15;
    final theme = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 20,
          backgroundColor: Colors.white,
        ),
        // bottomNavigationBar: const BottomNavBar(),
        body: Padding(
          padding: EdgeInsets.only(left: appPadding, right: appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Home Page Title
              Padding(
                padding: EdgeInsets.only(left: appPadding, bottom: 5.0),
                child: Text(
                  "Explore Restaurants",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              const SpaceY(5),

              // Search Bar
              Padding(
                padding: EdgeInsets.only(left: appPadding, right: appPadding),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search for a restaurant',
                      prefixIcon: Icon(Icons.search)),
                ),
              ),

              const SpaceY(15),

              // Restaurant List
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      // TODO modify dark theme
                      color: theme.isDarkTheme
                          ? const Color.fromARGB(255, 30, 50, 49)
                          : Colors.white),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _restaurantsFiltered.length,
                    itemBuilder: ((context, index) {
                      // get favorite restaurant object from localstorage
                      List<dynamic> favoriteRestaurants =
                          jsonDecode(KwunLocalStorage.getString("favorites"));

                      var resObj = _restaurantsFiltered[index];

                      return RestaurantCard(
                        resObj: resObj,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
