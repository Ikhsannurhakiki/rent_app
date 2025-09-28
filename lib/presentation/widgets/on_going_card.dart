import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

import '../../data/dummy/dummy.dart';

class OnGoingCard extends StatefulWidget {
  const OnGoingCard({super.key});

  @override
  State<OnGoingCard> createState() => _OnGoingCardState();
}

class _OnGoingCardState extends State<OnGoingCard> {
  int _currentIndex = 0;
  final unit = Unit.dummy();
  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.directions_car,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.timer,
                        size: 26,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Toyota Avanza",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.lock_clock, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            "Expired On : 26 July",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Pekanbaru, Riau",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: unit.images.asMap().entries.map((
                          entry,
                          ) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: _currentIndex == entry.key ? 10.0 : 4.0,
                          height: _currentIndex == entry.key ? 10.0 : 4.0,
                          margin: const EdgeInsets.symmetric(vertical: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
