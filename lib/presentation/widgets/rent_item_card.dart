import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

import '../../data/entities/Unit.dart';
import '../../data/entities/rentItemEntity.dart';

class RentCard extends StatelessWidget {
  final Unit item;

  const RentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190, height: 250,
      child: Card(
        shadowColor: Colors.black,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Image.network(item.thumbnailImageUrl, fit: BoxFit.scaleDown),
              ),
              const SizedBox(height: 8),
              Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(item.dailyRate.toString(), style: TextStyle(color: AppColors.darkTeal.color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
