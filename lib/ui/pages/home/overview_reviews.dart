import 'package:flutter/material.dart';
import 'reserve_form.dart';
import 'package:provider/provider.dart';

import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/utils/format_date.dart';

class OverviewAndReviews extends StatefulWidget {
  final Map resObj;
  const OverviewAndReviews({
    super.key,
    required this.resObj,
  });

  @override
  State<OverviewAndReviews> createState() => _OverviewAndReviewsState();
}

class _OverviewAndReviewsState extends State<OverviewAndReviews> {
  @override
  build(BuildContext context) {
    List<dynamic> reviews = widget.resObj["reviews"];

    List<dynamic> menuItems = widget.resObj["menu_items"];

    String overview = widget.resObj["description"] ?? "";

    final theme = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Overview',
              ),
              Tab(
                text: 'Reviews',
              ),
              Tab(
                text: 'Menu',
              ),
            ],
            labelColor: theme.isDarkTheme
                ? const Color.fromARGB(255, 170, 144, 204)
                : const Color.fromARGB(255, 242, 87, 87),
            unselectedLabelColor:
                theme.isDarkTheme ? Colors.white : Colors.black,
            indicatorColor: theme.isDarkTheme
                ? const Color.fromARGB(255, 170, 144, 204)
                : const Color.fromARGB(255, 242, 87, 87),
          ),
        ),
        body: TabBarView(
          children: [
            // Overview
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        overview,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                const Expanded(child: Text("")), //Reserve button
                ReserveButton(resObj: widget.resObj),
              ],
            ),

            //Reviews
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: ((context, index) {
                var reviewObj = reviews[index];
                return ReviewCard(
                  reviewObj: reviewObj,
                );
              }),
            ),

            //Menu
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menuItems.length,
                      itemBuilder: ((context, index) {
                        var foodObj = menuItems[index];
                        return FoodCard(
                          foodObj: foodObj,
                        );
                      }),
                    ),
                  ),
                ),
                ReserveButton(resObj: widget.resObj),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Map reviewObj;
  final Map user;

  ReviewCard({
    super.key,
    required this.reviewObj,
  }) : user = reviewObj["users"];

  @override
  Widget build(BuildContext context) {
    double padding = 10;

    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  user["avatar_url"] ??
                      "https://static.vecteezy.com/system/resources/thumbnails/020/911/740/small_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: padding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user["full_name"],
                    style: myCustomStyle,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      reviewObj["rating"].toString(),
                      style: myCustomStyle,
                    ),
                  ]),
                ],
              )
            ],
          ),
          Text(formatDate(reviewObj["created_at"])),
          Text(
            reviewObj["content"].toString(),
          )
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Map foodObj;
  const FoodCard({
    super.key,
    required this.foodObj,
  });

  @override
  Widget build(BuildContext context) {
    double widthImage = 200;
    double heightImage = 110;
    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodObj["image_url"],
              width: widthImage,
              height: heightImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            foodObj["name"].toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "\$${foodObj["price"]}",
          ),
        ],
      ),
    );
  }
}

class ReserveButton extends StatelessWidget {
  final Map resObj;
  const ReserveButton({
    super.key,
    required this.resObj,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.isDarkTheme
            ? const Color.fromARGB(255, 170, 144, 204)
            : const Color.fromARGB(255, 242, 87, 87),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReserveForm(resObj: resObj),
              ),
            );
          },
          child: Text(
            "Reserve a Table",
            style: Theme.of(context).textTheme.bodyLarge,
            // style: TextStyle(
            //   color: Colors.white,
            //   fontWeight: FontWeight.w700,
            //   fontSize: 16,
            // ),
          ),
        ),
      ),
    );
  }
}
