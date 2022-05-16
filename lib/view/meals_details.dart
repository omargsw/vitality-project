import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/model/food_plan.dart';
import 'meal_details_card.dart';
import 'package:http/http.dart' as http;

class MealsDetails extends StatefulWidget {
  final String? title;
  final String? imagePath;
  final int? categoryId;
  const MealsDetails(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.categoryId})
      : super(key: key);

  @override
  State<MealsDetails> createState() => _MealsDetailsState();
}

class _MealsDetailsState extends State<MealsDetails> {
  bool isLoading = false;
  int? userId = sharedPreferences!.getInt('userID');

  List<GetFoodPlan> foodPlan = [];
  Future fetchFoodPlan() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.customerGetFood +
          "?cat_id=${widget.categoryId}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetFoodPlan> list = getFoodPlanFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchFoodPlan] $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodPlan().then((list) {
      setState(() {
        foodPlan = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: mainAppBar(title: widget.title, iconButton: null),
      body: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 2.85,
            ),
            itemCount: foodPlan.length,
            itemBuilder: (_, index) {
              GetFoodPlan get = foodPlan[index];
              return GestureDetector(
                onTap: () {
                  Get.to(MealDetailsCard(
                    imagePath:
                        WebConfig.baseUrl + WebConfig.centerImages + get.image,
                    title: get.name,
                    desc: get.description,
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
                            child: Image.network(
                              widget.imagePath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            width: width,
                            padding: const EdgeInsets.all(5),
                            color: Colors.white54,
                            child: Center(
                              child: Text(
                                get.name,
                                style: AppFonts.tajawal14BlueW600,
                                textAlign: TextAlign.center,
                              ),
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
