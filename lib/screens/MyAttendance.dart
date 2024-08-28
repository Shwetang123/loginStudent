import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/Attendance.dart';
import '../services/Api_service.dart'; // Make sure your ApiService is set up to fetch Attendance data

class MyAttendanceScreen extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<MyAttendanceScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Future<Attendance> fetchAttendance;

  @override
  void initState() {
    super.initState();
    fetchAttendance = ApiService().fetchAttendance();
  }

  int getTotalPresentDays(AttMonths? month) {
    return month?.totalPresentDays ?? 0;
  }

  int getTotalAbsentDays(AttMonths? month) {
    return month?.totalAbsentDays ?? 0;
  }

  List<DateTime> _getPresentDays(List<Entries>? entries) {
    return entries?.where((entry) => entry.atStatus == "Present").map((entry) {
      return DateTime.parse(entry.atDate!); // Adjust the date parsing as needed
    }).toList() ?? [];
  }

  List<DateTime> _getAbsentDays(List<Entries>? entries) {
    return entries?.where((entry) => entry.atStatus == "Absent").map((entry) {
      return DateTime.parse(entry.atDate!); // Adjust the date parsing as needed
    }).toList() ?? [];
  }

  AttMonths? _getMonthData(List<AttMonths>? attMonths, DateTime focusedDay) {
    if (attMonths == null) return null;
    try {
      return attMonths.firstWhere(
            (m) =>
        DateTime.parse(m.entries!.first.atDate!).month == focusedDay.month &&
            DateTime.parse(m.entries!.first.atDate!).year == focusedDay.year,
      );
    } catch (e) {
      return null; // Return null if no matching month is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Attendance",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MainFont",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Attendance>(
        future: fetchAttendance,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.attMonths == null) {
            return const Center(child: Text('No data available'));
          }

          final attendance = snapshot.data!;
          final month = _getMonthData(attendance.attMonths, _focusedDay);

          final presentDays = _getPresentDays(month?.entries);
          final absentDays = _getAbsentDays(month?.entries);

          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                headerStyle: const HeaderStyle(
                    titleCentered: true, formatButtonVisible: false),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  defaultBuilder: (context, date, _) {
                    if (presentDays.contains(date)) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (absentDays.contains(date)) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildStatusButton(
                      "Absent", Colors.red, getTotalAbsentDays(month)),
                  const SizedBox(width: 16),
                  buildStatusButton(
                      "Present", Colors.green, getTotalPresentDays(month)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildStatusButton(String title, Color color, int count) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            title == "Absent" ? Icons.close : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            "$title  $count",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
