import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

class OnGoingCard extends StatelessWidget {
  const OnGoingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          borderOnForeground: true,
          surfaceTintColor: Colors.white,
          elevation: 3,
          color: AppColors.green.color,
          child: ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Toyota Avanza", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Rent Until: 26 July"),
          ),
        ),
      ],
    );
  }
}