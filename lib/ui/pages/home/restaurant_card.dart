import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_project/config/constants.dart';
import 'package:group_project/ui/utils/format_address.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'restaurant_info.dart';
import 'package:provider/provider.dart';

import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/toggle_icon_button.dart';

class RestaurantCard extends StatefulWidget {
  final Map<String, dynamic> resObj;

  const RestaurantCard({
    super.key,
    required this.resObj,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();

    // check if this restaurant is favorite
    List<dynamic> favoriteRestaurants =
        jsonDecode(KwunLocalStorage.getString("favorites"));
    bool isfavorite = favoriteRestaurants.any((element) =>
        element["restaurant_name"] == widget.resObj["restaurant_name"]);

    setState(() => isFavorite = isfavorite);
  }

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double padding = 10;
    // double fontSizeName = 18, fontSizeLocation = 12, fontSizeOther = 14;
    final theme = Provider.of<ThemeProvider>(context);

    return TextButton(
      onPressed: () async {
        // save ther restaurant object to the provider
        context
            .read<ReserveFormProvider>()
            .updateRestaurantObject(widget.resObj);

        context
            .read<ReserveFormProvider>()
            .updateCurrentRestaurant(widget.resObj["restaurant_name"]);

        final onChangedisFavorite = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantInfo(resObj: widget.resObj),
          ),
        );

        setState(() {
          isFavorite = onChangedisFavorite;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 170, 144, 204)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(149, 157, 165, 0.2),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ]),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      widget.resObj["image_url"].toString(),
                      height: 110,
                      width: contextWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(""),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ToggleHeartIconButton(
                            initialValue: isFavorite,
                            onChanged: (bool isToggled) {
                              // get from data from localstorage
                              String favoriteRestaurantsString =
                                  KwunLocalStorage.getString("favorites");

                              List<dynamic> favoriteRestaurants =
                                  jsonDecode(favoriteRestaurantsString);

                              // either save to favorites
                              if (isToggled) {
                                favoriteRestaurants.add(widget.resObj);
                              }

                              // or remove from favorites
                              else {
                                // remove by name
                                favoriteRestaurants.removeWhere((curr) =>
                                    curr["id"] == widget.resObj["id"]);
                              }

                              // save new data
                              KwunLocalStorage.setString(
                                  "favorites", jsonEncode(favoriteRestaurants));
                            },
                          )),
                    ],
                  ),
                ],
              ),
              const SpaceY(8),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.resObj["restaurant_name"],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 215, 207, 7),
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.resObj["rating"].toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      // style: TextStyle(
                      //   color: const Color.fromARGB(254, 0, 0, 0),
                      //   fontSize: fontSizeOther,
                      //   fontWeight: FontWeight.w700,
                      // ),
                    ),
                  ],
                ),
              ),
              const SpaceY(2),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      formatAddressToStateAndCity(widget.resObj["address"]),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.attach_money,
                    color: theme.isDarkTheme ? Colors.white70 : Colors.black,
                    size: 18,
                  ),
                  Text(
                    "${widget.resObj["min_price"].toString()} - ${widget.resObj["max_price"].toString()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                    // style: TextStyle(
                    //   color: const Color.fromARGB(254, 0, 0, 0),
                    //   fontSize: fontSizeOther,
                    //   fontWeight: FontWeight.w700,
                    // ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
    );
  }
}
