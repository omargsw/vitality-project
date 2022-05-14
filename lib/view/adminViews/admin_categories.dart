import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/categories.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/view/adminViews/edit_news.dart';

class AdminCategories extends StatefulWidget {
  const AdminCategories({Key? key}) : super(key: key);

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
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

  Future deleteCategory(var categoryid) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.adminRemoveCategory + "?id=$categoryid";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[deleteCategory] $e");
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(const Addnews(
            title: "Add Categories",
            isName: false,
            type: 'category',
          ));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
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
                : ListView.builder(
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      GetCaregories get = category[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Padding(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialogWidget(
                                                  title:
                                                      "Are you sure to delete this category?",
                                                  onTapYes: () {
                                                    deleteCategory(get.id);
                                                    setState(() {
                                                      fetchCategory()
                                                          .then((categories) {
                                                        setState(() {
                                                          category = categories;
                                                        });
                                                      });
                                                    });
                                                    Get.back();
                                                  });
                                            });
                                      },
                                      child: const IconButtonWidget(
                                          color: Colors.red,
                                          icons: Icons.delete)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.to(EditNews(
                                          title: 'Edit Category',
                                          isName: false,
                                          type: 'category',
                                          image: WebConfig.baseUrl +
                                              WebConfig.categoryImages +
                                              get.image,
                                          titleNews: '',
                                          desc: get.name,
                                          id: get.id,
                                        ));
                                      },
                                      child: const IconButtonWidget(
                                          color: Colors.blue,
                                          icons: Icons.edit)),
                                ],
                              ),
                            ),
                          ],
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
