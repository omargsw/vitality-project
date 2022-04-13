import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/meals_card.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:vitality/view/adminViews/admin_meals_details.dart';
import 'package:vitality/view/centerViews/food_plan.dart';
import 'package:vitality/view/meals_details.dart';

class CenterCategories extends StatefulWidget {
  const CenterCategories({Key? key}) : super(key: key);

  @override
  State<CenterCategories> createState() => _CenterCategoriesState();
}

class _CenterCategoriesState extends State<CenterCategories> {
  List title = [
    "Breakfast",
    "Lunch",
    "Dinner"
  ];
  List image = [
    'assets/images/breakfast.jpg',
    'assets/images/lunch.jpg',
    'assets/images/dinner.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Daily meals",style: AppFonts.tajawal20BlueW600,),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(const CenterFoodPlan(title: "title",imagePath: 'assets/images/breakfast.jpg',));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.asset(
                                    image[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  color: const Color(0xffB5E0F9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    title[index],
                                                    style: AppFonts.tajawal20BlueW600
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}
