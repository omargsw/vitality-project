import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:vitality/view/adminViews/admin_meal_details_card.dart';

class MealsDetailsAdmin extends StatefulWidget {
  final String? title;
  final String? imagePath;
  const MealsDetailsAdmin(
      {Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  State<MealsDetailsAdmin> createState() => _MealsDetailsAdminState();
}

class _MealsDetailsAdminState extends State<MealsDetailsAdmin> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: mainAppBar(title: widget.title, iconButton: null),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(const Addnews(
            title: "Add Categories",
            isName: true,
            type: '',
          ));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 2.85,
            ),
            itemCount: 10,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(const MealDetailsCardAdmin(
                    imagePath: 'assets/images/dinner.jpg',
                    title: "name",
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          // offset: const Offset(3, 3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              "assets/images/logo.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(5),
                            color: Colors.white54,
                            child: Text(
                              "Name of center",
                              style: AppFonts.tajawal14BlueW600,
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
