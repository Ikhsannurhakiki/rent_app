


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePickerScreen extends StatefulWidget {
  const DateRangePickerScreen({super.key});

  @override
  State<DateRangePickerScreen> createState() => _DateRangePickerScreenState();
}

class _DateRangePickerScreenState extends State<DateRangePickerScreen> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // Contoh tanggal yang sudah dibooking
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
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            onRangeSelected: (start, end, focusedDay) {
              // Cek apakah ada tanggal yang dibooking di dalam rentang
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rentang tanggal berisi tanggal yang sudah dibooking!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              }

              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
              });
            },
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (isBooked(day)) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          if (_rangeStart != null && _rangeEnd != null)
            Text(
              'Rentang Dipilih: ${_rangeStart!.toLocal()} - ${_rangeEnd!.toLocal()}',
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}