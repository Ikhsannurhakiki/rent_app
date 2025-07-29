import 'package:flutter/material.dart';

import '../../data/entities/Unit.dart';

class DetailScreen extends StatelessWidget {
  final Unit unit;

  const DetailScreen({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(unit.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            unit.thumbnailImageUrl != null
                ? Image.network(unit.thumbnailImageUrl!)
                : SizedBox.shrink(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unit.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  unit.description != null
                      ? Text(unit.description!)
                      : SizedBox.shrink(),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.directions_car),
                      SizedBox(width: 8),
                      Text('Type: ${unit.unitType}'),
                    ],
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 8),
                      Text(
                        'Rate: ${unit.currency} ${unit.dailyRate.toStringAsFixed(0)} / day',
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text('Location: ${unit.location}'),
                    ],
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(width: 8),
                      Text('Status: ${unit.availabilityStatus}'),
                    ],
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
