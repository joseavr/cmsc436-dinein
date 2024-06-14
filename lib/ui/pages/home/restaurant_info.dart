import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/utils/format_address.dart';
import 'package:provider/provider.dart';
import 'overview_reviews.dart';

import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/toggle_icon_button.dart';
import 'package:group_project/providers/theme.provider.dart';

class RestaurantInfo extends StatefulWidget {
  final Map resObj;

  const RestaurantInfo({
    super.key,
    required this.resObj,
  });

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
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
    double padding = 18;
    double paddingHeight = 12;
    double padding2 = 20;
    double fontSizeName = 20;
    final theme = Provider.of<ThemeProvider>(context);

    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

    double imageHeight = 200;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //image background title
            SizedBox(
              width: contextWidth,
              height: imageHeight,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.resObj["image_url"].toString(),
                      width: contextWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.bottomCenter,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          const Color.fromARGB(235, 0, 0, 0),
                        ],
                      ),
                    ),
                    child: const Text(""),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.only(left: 5),
                          child: BackButton(
                              onPressed: () => Navigator.pop(context, isFavorite),
                              color: theme.isDarkTheme
                                  ? Theme.of(context).primaryColor
                                  : Colors.black),
                        ),
                      ),
                      const Expanded(
                        child: Text(""),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 40,
                          height: 40,
                          child: ToggleHeartIconButton(
                            initialValue: isFavorite,
                            onChanged: (bool isToggled) {
                              setState(() => isFavorite = isToggled);

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
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: padding2, right: padding2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Restaurant name
                  Text(
                    widget.resObj["restaurant_name"],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  //Short location
                  Row(
                    children: [
                      Text(
                        formatAddressToStateAndCity(widget.resObj["address"]),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Expanded(child: Text("")),
                      Row(children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade400,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.resObj["rating"].toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${widget.resObj["reviews_count"]} Reviews)",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ]),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "${widget.resObj["food_categories"]["category_name"].toString().replaceRange(0, 1, widget.resObj["food_categories"]["category_name"].toString().substring(0, 1).toUpperCase())} Restaurant",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      //Opening Hours
                      if (widget.resObj["working_start"] != null)
                        Row(
                          children: [
                            Icon(
                              Icons.query_builder,
                              color: theme.isDarkTheme
                                  ? const Color.fromARGB(255, 170, 144, 204)
                                  : const Color.fromARGB(255, 242, 87, 87),
                            ),
                            SizedBox(width: padding),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Opening Hours",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "${widget.resObj["working_start"]} - ${widget.resObj["working_end"]}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            )
                          ],
                        ),

                      SizedBox(
                        height: paddingHeight,
                      ),
                      //Detailed locations
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: theme.isDarkTheme
                                ? const Color.fromARGB(255, 170, 144, 204)
                                : const Color.fromARGB(255, 242, 87, 87),
                          ),
                          SizedBox(width: padding),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.resObj["address"],
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: paddingHeight,
                      ),

                      //Phone number
                      if (widget.resObj["phone"] != null)
                        Row(
                          children: [
                            Icon(
                              Icons.local_phone_outlined,
                              color: theme.isDarkTheme
                                  ? const Color.fromARGB(255, 170, 144, 204)
                                  : const Color.fromARGB(255, 242, 87, 87),
                            ),
                            SizedBox(width: padding),
                            Text(
                              widget.resObj["phone"] ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: paddingHeight,
                      ),

                      //Email
                      if (widget.resObj["email"] != null)
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: theme.isDarkTheme
                                  ? const Color.fromARGB(255, 170, 144, 204)
                                  : const Color.fromARGB(255, 242, 87, 87),
                            ),
                            SizedBox(width: padding),
                            Text(
                              widget.resObj["email"],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 280,
                    width: contextWidth,
                    child: OverviewAndReviews(
                      resObj: widget.resObj,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
