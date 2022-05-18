import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/categories.dart';
import 'package:vitality/view/centerViews/food_plan.dart';
import 'package:http/http.dart' as http;

class CenterCategories extends StatefulWidget {
  const CenterCategories({Key? key}) : super(key: key);

  @override
  State<CenterCategories> createState() => _CenterCategoriesState();
}

class _CenterCategoriesState extends State<CenterCategories> {
  bool isLoading = false;
  List title = ["Breakfast", "Lunch", "Dinner"];
  List image = [
    'assets/images/breakfast.jpg',
    'assets/images/lunch.jpg',
    'assets/images/dinner.jpg',
  ];

  List<GetCaregories> category = [];
  Future fetchCategory() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.getCategory;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetCaregories> categories =
            getCaregoriesFromJson(response.body);
        return categories;
      }
    } catch (e) {
      log("[fetchCategory] $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategory().then((categories) {
      setState(() {
        category = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Daily meals",
              style: AppFonts.tajawal20BlueW600,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : category.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "No results",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          GetCaregories get = category[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(CenterFoodPlan(
                                categoryId: get.id,
                                title: get.name,
                                imagePath: WebConfig.baseUrl +
                                    WebConfig.categoryImages +
                                    get.image,
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 8, bottom: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 2,
                                            child: Image.network(
                                              WebConfig.baseUrl +
                                                  WebConfig.categoryImages +
                                                  get.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            color: const Color(0xffB5E0F9),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(get.name,
                                                            style: AppFonts
                                                                .tajawal20BlueW600),
                                                      ],
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
