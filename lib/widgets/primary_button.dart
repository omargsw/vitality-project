import 'package:flutter/material.dart';
import 'package:vitality/components/fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color backgroundcolor;

  const PrimaryButton({
    required this.title,
    required this.width,
    required this.backgroundcolor,
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: backgroundcolor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        title,
        style: AppFonts.tajawal16WhiteW600,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
