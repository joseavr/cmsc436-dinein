import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';

class ReserveForm extends StatelessWidget {
  final Map resObj;
  const ReserveForm({super.key, required this.resObj});

  @override
  Widget build(BuildContext context) {
    const myCustomStyle = TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: theme.isDarkTheme
                ? const Color.fromARGB(255, 43, 45, 44)
                : Colors.grey.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const BackButton(),
                Text(
                  "Reserve a Table",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const CustomTableCalendar(),
            const Expanded(
              child: TimeGrid(),
            ),
            const CounterWidget(),
            const SizedBox(
              height: 5,
            ),
            const ReserveButton(),
          ],
        ),
      ),
    );
  }
}

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomTableCalendar();
}

class _CustomTableCalendar extends State<CustomTableCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    _selectedDay = context.watch<ReserveFormProvider>().selectedDate;
    final theme = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        TableCalendar(
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2025, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            context.read<ReserveFormProvider>().updateSelectedDate(selectedDay);
            setState(() {
              //update selected state here
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          // Style the calendar
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 173, 122, 153)
                  : const Color.fromARGB(255, 167, 29, 49),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 255, 198, 172).withOpacity(0.2)
                  : const Color.fromARGB(255, 186, 143, 149).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class TimeGrid extends StatelessWidget {
  const TimeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantObj = context.watch<ReserveFormProvider>().getRestaurantObj;
    String openingTime = restaurantObj["working_start"];
    String closingTime = restaurantObj["working_end"];

    List<String> times = generateTimeSlots(openingTime, closingTime);
    return Scaffold(
        body: GridView.builder(
      itemCount: times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 1.5),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: TimeCard(time: times[index]),
        );
      },
    ));
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({super.key, required this.time});
  final String time;

  @override
  Widget build(BuildContext context) {
    final String selectedTime =
        context.watch<ReserveFormProvider>().selectedTime;
    final bool selected = selectedTime.compareTo(time) == 0;
    final theme = Provider.of<ThemeProvider>(context);
    return TextButton(
      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
      onPressed: () {
        context.read<ReserveFormProvider>().updateSelectedTime(time);
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
              color: selected
                  ? (theme.isDarkTheme
                        ? const Color.fromARGB(255, 83, 28, 179)
                        : const Color.fromARGB(255, 167, 29, 49))
                  : (theme.isDarkTheme
                      ? const Color.fromARGB(255, 173, 122, 153)
                      : const Color.fromARGB(255, 186, 143, 149))),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
                fontSize: 10,
                color: selected
                    ? (theme.isDarkTheme
                        ? const Color.fromARGB(255, 83, 28, 179)
                        : const Color.fromARGB(255, 175, 91, 91))
                    : (theme.isDarkTheme
                        ? const Color.fromARGB(255, 173, 122, 153)
                        : const Color.fromARGB(255, 73, 136, 218))),
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final int guest = context.watch<ReserveFormProvider>().guest;
    final theme = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Guests: ",
          style: TextStyle(fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 173, 122, 153)
                  : const Color.fromARGB(255, 167, 29, 49),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 45,
                child: TextButton(
                  onPressed: () {
                    if (guest > 1) {
                      context
                          .read<ReserveFormProvider>()
                          .updateGuest(guest - 1);
                    }
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    '$guest',
                    style: const TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 45,
                child: TextButton(
                  onPressed: () {
                    if (guest < 50) {
                      context
                          .read<ReserveFormProvider>()
                          .updateGuest(guest + 1);
                    }
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReserveButton extends StatelessWidget {
  const ReserveButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final selectedTime = context.watch<ReserveFormProvider>().selectedTime;
    final selectedDate = context.watch<ReserveFormProvider>().selectedDate;
    final theme = Provider.of<ThemeProvider>(context);
    bool checkSelectedTimeAndDate() {
      if (selectedTime.isEmpty || selectedDate == null) {
        return false;
      } else {
        return true;
      }
    }

    return TextButton(
      onPressed: () {
        if (checkSelectedTimeAndDate()) {
          showDialog(
            context: context,
            builder: (context) => const ConfirmDialog(),
          );
        } else {
          const snackBar = SnackBar(
            duration: Duration(milliseconds: 500),
            content: Center(
              child: Text(
                "Please select both date & time",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Color.fromARGB(137, 247, 100, 100),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 173, 122, 153)
                  : const Color.fromARGB(255, 167, 29, 49),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Confirm",
            style: TextStyle(
              color: theme.isDarkTheme ? const Color.fromARGB(255, 3, 96, 22) : const Color.fromARGB(255, 99, 235, 126),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

List<String> generateTimeSlots(String openingTime, String closingTime) {
  List<String> timeSlots = [];
  List<String> defaultTimeSlots = [
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
    "7:00 PM",
    "8:00 PM"
  ];
  List openTokens = openingTime.split(":");
  List closeTokens = closingTime.split(":");
  int openTime = int.parse(openTokens[0]);
  String openP = openTokens[1].split(" ")[1];
  String closeP = closeTokens[1].split(" ")[1];

  closingTime = "${int.parse(closeTokens[0]) - 1}:00 $closeP";

  if (closingTime.compareTo("11:00 AM") == 0) {
    closingTime = "11:00 PM";
  } else if (closingTime.compareTo("11:00 PM") == 0) {
    closingTime = "11:00 AM";
  } else if (closingTime.compareTo("0:00 AM") == 0) {
    closingTime = "12:00 AM";
  } else if (closingTime.compareTo("0:00 PM") == 0) {
    closingTime = "12:00 PM";
  }

  if (openingTime.compareTo("$openTime:00 $openP") != 0) {
    openTime = openTime + 1;
    if (openTime == 12) {
      if (openP.compareTo("AM") == 0) {
        openP = "PM";
      } else {
        openP = "AM";
      }
    }
    if (openTime > 12) {
      openTime = openTime - 12;
    }
  }

  String currTime = "";
  int loop = 0;

  while (currTime.compareTo(closingTime) != 0) {
    if (loop > 24) {
      return defaultTimeSlots;
    }
    loop += 1;
    currTime = "$openTime:00 $openP";
    timeSlots.add(currTime);
    openTime += 1;
    if (openTime == 12) {
      if (openP.compareTo("AM") == 0) {
        openP = "PM";
      } else {
        openP = "AM";
      }
    }
    if (openTime > 12) {
      openTime -= 12;
    }
  }

  return timeSlots;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // necessary data to insert into the database
    final String selectedDateToInsert = DateFormat('yyyy-MM-dd')
        .format(context.watch<ReserveFormProvider>().selectedDate!);
    final String selectedTimeToInsert =
        context.watch<ReserveFormProvider>().selectedTime;
    final Map<String, dynamic> selectedRestaurantObj =
        context.watch<ReserveFormProvider>().getRestaurantObj;
    final userId = context.watch<UserProvider>().getUser.id;

    final String selectedTime = context
        .watch<ReserveFormProvider>()
        .selectedTime
        .replaceAll("AM", "am")
        .replaceAll("PM", "pm");
    final DateTime? selectedDate =
        context.watch<ReserveFormProvider>().selectedDate;

    final guest = context.watch<ReserveFormProvider>().guest;
    final restaurantName =
        context.watch<ReserveFormProvider>().currentRestaurant;

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 202, 200, 186),
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Text(restaurantName,
                textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 111, 94, 83),
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
              ),
              const Expanded(child: Text("")),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "Table for $guest on ${DateFormat('EEEE').format(selectedDate!)}, ${DateFormat.yMMMMd().format(selectedDate)} at $selectedTime",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 53, 53, 49),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const Expanded(child: Text("")),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 180, 47, 47),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 14, left: 14),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Expanded(child: Text("")),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 162, 176, 120),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 14, left: 14),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Color.fromARGB(255, 28, 84, 16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                      onPressed: () async {
                        showKwunSnackBar(
                            context: context,
                            message:
                                "Thank you! Your reservation is confirmed.",
                            color: Colors.green);

                        try {
                          await Supabase.instance.client
                              .from('reservations')
                              .insert({
                            'date': selectedDateToInsert,
                            'time': selectedTimeToInsert,
                            'guests': guest,
                            'is_reserved': true,
                            'restaurant_id': selectedRestaurantObj['id'],
                            'user_id': userId,
                          });
                        } on Exception catch (e) {
                          if (context.mounted) {
                            showKwunSnackBar(
                                context: context, message: e.toString());
                          }
                        }

                        if (!context.mounted) return;

                        Navigator.of(context).pop();
                        context.read<ReserveFormProvider>().updateGuest(1);
                        context
                            .read<ReserveFormProvider>()
                            .updateSelectedTime("");
                        context
                            .read<ReserveFormProvider>()
                            .updateSelectedDate(DateTime.now());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
