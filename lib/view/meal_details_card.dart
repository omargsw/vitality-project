import 'package:flutter/material.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';

class MealDetailsCard extends StatefulWidget {
  final String? title;
  final String? imagePath;
  final String? desc;
  const MealDetailsCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.desc,
  }) : super(key: key);

  @override
  State<MealDetailsCard> createState() => _MealDetailsCardState();
}

class _MealDetailsCardState extends State<MealDetailsCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: mainAppBar(title: widget.title, iconButton: null),
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 325,
                width: width * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.desc!,
                      style: AppFonts.tajawal20WhiteW600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
