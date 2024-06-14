import 'package:flutter/material.dart';
import 'package:group_project/ui/utils/convert_to_datetime.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'previous_list.dart';
import 'upcoming_list.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  List<Map<String, dynamic>> _reservationList = [];

  @override
  initState() {
    super.initState();
    fetchUserReservations();
  }

  Future fetchUserReservations() async {
    try {
      final response = await Supabase.instance.client
          .from('reservations')
          .select('*, restaurants(*)');

      setState(() => _reservationList = response);
    } on Exception catch (e) {
      if (mounted) showKwunSnackBar(context: context, message: e.toString());
    }
  }

  List<Map<String, dynamic>> filterByUpcomingReservations(
      List<Map<String, dynamic>> reservationList) {
    return reservationList.where((element) {
      DateTime now = DateTime.now();
      DateTime reservationDate =
          convertToDateTime(element['date'], element['time']);
      return reservationDate.isAfter(now);
    }).toList();
  }

  List<Map<String, dynamic>> filterByPreviousReservations(
      List<Map<String, dynamic>> reservationList) {
    return reservationList.where((element) {
      DateTime now = DateTime.now();
      DateTime reservationDate =
          convertToDateTime(element['date'], element['time']);
      return reservationDate.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double padding = 10;

    List<Map<String, dynamic>> upcomingReservations =
        filterByUpcomingReservations(_reservationList);

    List<Map<String, dynamic>> previousReservations =
        filterByPreviousReservations(_reservationList);

    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding, top: 15),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // toolbarHeight: 20,
          title: Text(
            "My Reservations",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Previous"),
              ]),
            ),
            body: TabBarView(children: [
              UpcomingList(
                reservations: upcomingReservations,
                refreshReservation: fetchUserReservations
              ),
              PreviousList(reservations: previousReservations),
            ]),
          ),
        ),
      ),
    );
  }
}
