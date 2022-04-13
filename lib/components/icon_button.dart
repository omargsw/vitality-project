import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Color? color;
  final IconData? icons;
  const IconButtonWidget({Key? key,required this.color,required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
      child: Center(
          child: Icon(icons,color: Colors.white,)
      ),
    );
  }
}
