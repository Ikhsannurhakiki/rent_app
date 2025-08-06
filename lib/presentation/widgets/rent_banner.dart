import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

import '../../data/dummyItems.dart';

class RentBanner extends StatelessWidget {
  final List<RentItem> items = [
    RentItem(icon: Icons.directions_car, label: 'Car'),
    RentItem(icon: Icons.motorcycle, label: 'Motorcycle'),
    RentItem(icon: Icons.house, label: 'House'),
    RentItem(icon: Icons.more_horiz, label: 'Others'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.95,
            aspectRatio: 16 / 9,
          ),
          items: bannerUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    url,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 85,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: items.map((item) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: AppColors.blue.color,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              item.icon,
                              size: 28,
                              color: AppColors.blue.color,
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(item.label, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.bold)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RentItem {
  final IconData icon;
  final String label;

  RentItem({required this.icon, required this.label});
}
