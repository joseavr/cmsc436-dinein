import 'package:flutter/material.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpcomingList extends StatelessWidget {
  // TODO sort based on date
  final List<Map<String, dynamic>> reservations;

  final VoidCallback refreshReservation;

  const UpcomingList(
      {required this.refreshReservation,
      required this.reservations,
      super.key});

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
                  Text('${reservation['guests']} guests'),
                  Text('${reservation['date']} - ${reservation['time']}'),
                  Row(
                    children: [
                      const Expanded(child: Text("")),
                      TextButton(
                        onPressed: () async {
                          try {
                            await Supabase.instance.client
                                .from("reservations")
                                .delete()
                                .eq("id", reservation['id']);

                            // revalidate the data
                            refreshReservation();

                            if (!context.mounted) return;
                            showKwunSnackBar(
                                context: context,
                                message: "Your booking has been cancelled",
                                color: Colors.green);
                          } on Exception catch (e) {
                            if (!context.mounted) return;
                            showKwunSnackBar(
                                context: context, message: e.toString());
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.red, width: 2),
                            ),
                            child: const Text(
                              'Cancel Booking',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
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
