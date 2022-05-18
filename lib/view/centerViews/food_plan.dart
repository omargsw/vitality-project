import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/model/food_plan.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:vitality/view/adminViews/edit_news.dart';
import 'package:vitality/view/meal_details_card.dart';
import 'package:http/http.dart' as http;

class CenterFoodPlan extends StatefulWidget {
  final int? categoryId;
  final String? title;
  final String? imagePath;
  const CenterFoodPlan({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<CenterFoodPlan> createState() => _CenterFoodPlanState();
}

class _CenterFoodPlanState extends State<CenterFoodPlan> {
  bool isLoading = false;
  int? userId = sharedPreferences!.getInt('userID');

  List<GetFoodPlan> foodPlan = [];
  Future fetchFoodPlan() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.centerFoodPlan +
          "?center_id=$userId" +
          "&cat_id=${widget.categoryId}";
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

  Future deleteFoodPlan(var id) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.centerRemoveFoodPlan + "?id=$id";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[deleteFoodPlan] $e");
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(Addnews(
            title: "Add Food Plan",
            isName: true,
            newsId: widget.categoryId,
            type: 'food',
          ));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                )
              : foodPlan.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "No results",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 2.85,
                      ),
                      itemCount: foodPlan.length,
                      itemBuilder: (_, index) {
                        GetFoodPlan get = foodPlan[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(MealDetailsCard(
                              imagePath: WebConfig.baseUrl +
                                  WebConfig.foodImages +
                                  get.image,
                              title: get.name,
                              desc: get.description,
                            ));
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        // offset: const Offset(3, 3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            WebConfig.baseUrl +
                                                WebConfig.foodImages +
                                                get.image,
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
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialogWidget(
                                                title:
                                                    "Are you sure to delete this food plan?",
                                                onTapYes: () {
                                                  deleteFoodPlan(get.id);
                                                  setState(() {
                                                    fetchFoodPlan()
                                                        .then((list) {
                                                      setState(() {
                                                        foodPlan = list;
                                                      });
                                                    });
                                                  });
                                                  Get.back();
                                                });
                                          });
                                    },
                                    child: const IconButtonWidget(
                                        color: Colors.red, icons: Icons.delete),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(EditNews(
                                        title: get.name,
                                        id: 1,
                                        isName: true,
                                        type: "food",
                                        image: WebConfig.baseUrl +
                                            WebConfig.centerImages +
                                            get.image,
                                        desc: get.description,
                                        titleNews: get.name,
                                      ));
                                    },
                                    child: const IconButtonWidget(
                                        color: Colors.blue, icons: Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
