import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:group_project/ui/widgets/custom_snackbar.dart';

class PreviousList extends StatelessWidget {
  const PreviousList({required this.reservations, super.key});

  // TODO sort based on date
  final List<Map<String, dynamic>> reservations;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return Card(
            color: theme.isDarkTheme
                ? const Color.fromARGB(255, 167, 135, 209)
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reservation['restaurants']['restaurant_name'],
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700)),
                  Text(reservation['restaurants']['address']),
                  Text('${reservation['date']} - ${reservation['time']}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: Text("")),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReviewPage(reservationObj: reservation),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color.fromARGB(255, 165, 104, 14), width: 2),
                          ),
                          child: const Text(
                            'Rate Us',
                            style: TextStyle(
                                color: Color.fromARGB(255, 165, 104, 14),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> reservationObj;
  const ReviewPage({required this.reservationObj, super.key});
  @override
  State<StatefulWidget> createState() => _ReviewPage();
}

class _ReviewPage extends State<ReviewPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? _review;
  double _rating = 3;
  final fieldText = TextEditingController();

  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    double padding = 10;
    final theme = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Rate Us", style: Theme.of(context).textTheme.headlineLarge),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Your feedback is important to us.\nHelp us serve you better!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 32.0),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                  },
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: theme.isDarkTheme ? const Color.fromARGB(255, 170, 144, 204) : const Color.fromARGB(255, 164, 168, 209),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 15, right: 15, top: 5),
                    child: Form(
                      key: _key,
                      child: TextFormField(
                        maxLines: 5,
                        maxLength: 150,
                        controller: fieldText,
                        decoration: InputDecoration(
                          hintText: 'Write a review',
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                          border: InputBorder.none,
                          fillColor: theme.isDarkTheme ? const Color.fromARGB(255, 222, 198, 253) : const Color.fromARGB(255, 250, 228, 228)
                        ),
                        autocorrect: false,
                        obscureText: false,
                        autofocus: false,
                        validator: (value) {
                          if (null == value || value.isEmpty) {
                            return 'No review provided';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _review = newValue;
                        },
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final state = _key.currentState;
                    if (state!.validate()) {
                      setState(() {
                        state.save();
                      });
                    }

                    try {
                      await Supabase.instance.client.from('reviews').insert({
                        "content": _review,
                        "rating": _rating,
                        "restaurant_id": widget.reservationObj['restaurant_id'],
                        "user_id": widget.reservationObj['user_id'],
                      });

                      if (!context.mounted) return;
                      showKwunSnackBar(
                          context: context,
                          message: "Your review has been submitted",
                          color: Colors.green);
                    } on Exception catch (e) {
                      if (!context.mounted) return;
                      showKwunSnackBar(
                          context: context,
                          message: "Failed to submit your review: $e");
                    }

                    fieldText.clear();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: theme.isDarkTheme ? const Color.fromARGB(255, 170, 144, 204) : const Color.fromARGB(255, 164, 168, 209),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            color: theme.isDarkTheme ? Colors.white : Colors.black, fontWeight: FontWeight.w800),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
