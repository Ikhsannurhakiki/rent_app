import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();

  final List<DateTime> bookedDates = [
    DateTime(2025, 8, 15),
    DateTime(2025, 8, 18),
    DateTime(2025, 8, 20),
  ];

  bool isBooked(DateTime day) {
    return bookedDates.any((booked) =>
    booked.year == day.year &&
        booked.month == day.month &&
        booked.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    String? displayText;
    if (_rangeStart != null && _rangeEnd == null) {
      final start = _rangeStart!.toLocal();
      final dateFormat = DateFormat("d MMM yyyy");
      final startStr = dateFormat.format(start);
      displayText = "1 day ($startStr)";
    } else if (_rangeStart != null && _rangeEnd != null) {
      final start = _rangeStart!.toLocal();
      final end = _rangeEnd!.toLocal();
      final dayCount = end.difference(start).inDays + 1;
      final dateFormat = DateFormat("d MMM yyyy");
      final startStr = dateFormat.format(start);
      final endStr = dateFormat.format(end);
      displayText = "$dayCount days ($startStr - $endStr)";
    }else{
      displayText = "Pick the date";
    }

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime(
              DateTime.now().year + 1,
              DateTime.now().month,
              DateTime.now().day,
            ),
            focusedDay: _focusedDay,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: RangeSelectionMode.toggledOn,

            enabledDayPredicate: (day) {
              return !isBooked(day);
            },

            onDaySelected: (selectedDay, focusedDay) {
              if (!isBooked(selectedDay)) {
                setState(() {
                  _rangeStart = selectedDay;
                  _rangeEnd = null;
                  _focusedDay = focusedDay;
                });
                context.read<BookNotifier>().setRange(selectedDay, null);
              }
            },

            onRangeSelected: (start, end, focusedDay) {
              if (start != null && end != null) {
                bool conflict = false;
                DateTime current = start;
                while (current.isBefore(end.add(const Duration(days: 1)))) {
                  if (isBooked(current)) {
                    conflict = true;
                    break;
                  }
                  current = current.add(const Duration(days: 1));
                }
                if (conflict) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Rentang tanggal berisi tanggal yang sudah dibooked!',
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  );
                  return;
                }
              }

              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
                _focusedDay = focusedDay;
              });
              context.read<BookNotifier>().setRange(start, end);
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (isBooked(day)) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return null;
              },
              disabledBuilder: (context, day, focusedDay) {
                if (!day.isBefore(DateTime.now()) && isBooked(day)) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          if (displayText != null)
            Text(
              displayText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

        ],
      ),
    );
  }
}
