import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/colors/app_colors.dart';
import '../widgets/activity_card.dart';

class ActivityScreen extends StatelessWidget{
  const ActivityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Activity', style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: const [
          ActivityCard(
            icon: Icons.directions_car,
            title: "Car Rented",
            subtitle: "Toyota Avanza - July 22",
          ),
          ActivityCard(
            icon: Icons.home,
            title: "House Booking",
            subtitle: "2BR in Pekanbaru - Aug 1",
          ),
          ActivityCard(
            icon: Icons.message,
            title: "Message Sent",
            subtitle: "To renter of Yamaha Mio",
          ),
        ],
      )
      ,
    );
  }

}