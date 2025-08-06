import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';
import 'package:rent_app/presentation/style/typography/app_text_styles.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() onTap;

  const SubHeading({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(icon,  color: AppColors.blue.color, size: 18,),
          ),
        ),
      ],
    );
  }
}
