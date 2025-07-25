import 'package:flutter/material.dart';
import 'package:rent_app/presentation/widgets/on_going_card.dart';
import 'package:rent_app/presentation/widgets/subHeading.dart';

import '../../data/dummyItems.dart';
import '../style/colors/app_colors.dart';
import '../widgets/rent_banner.dart';
import '../widgets/rent_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/appbar/appbar.png", width: 100, height:60, fit: BoxFit.fitWidth,),
            FittedBox(
              child: Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 18, color: Colors.white,),
                  SizedBox(width: 4),
                  Text(
                    "Pekanbaru, Riau",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, size: 25, color: Colors.white,)
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RentBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SubHeading(title: 'On Going . . . . .', onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OnGoingCard()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SubHeading(title: 'Top Rented Near You', onTap: () {}),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyRentItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final item = dummyRentItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: RentCard(item: item),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SubHeading(title: 'Closest Recomendation', onTap: () {}),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyRentItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final item = dummyRentItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: RentCard(item: item),
                  );
                },
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
