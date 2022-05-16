import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/meals_card.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/advertisment.dart';
import 'package:vitality/model/categories.dart';
import 'package:vitality/view/meals_details.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

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

  List<GetAdvertisment> advertisments = [];
  Future fetchAdvertisment() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.getAdvertisment;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetAdvertisment> list =
            getAdvertismentFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchAdvertisment] $e");
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
    fetchAdvertisment().then((list) {
      setState(() {
        advertisments = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "News",
                style: AppFonts.tajawal20BlueW600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: advertisments.length,
                    itemBuilder: (context, index, realIndex) {
                      GetAdvertisment get = advertisments[index];
                      if (advertisments.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondaryColor,
                          ),
                        );
                      } else {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 2,
                                      child: Image.network(
                                        WebConfig.baseUrl +
                                            WebConfig.advImages +
                                            get.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                        color: Color(0xffD5D8D9),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    get.description,
                                                    style: AppFonts
                                                        .tajawal20BlueW600,
                                                    textAlign: TextAlign.center,
                                                  ),
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
                        );
                      }
                    },
                    //Slider Container properties
                    options: CarouselOptions(
                      height: 275.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Daily meals",
                style: AppFonts.tajawal20BlueW600,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        GetCaregories get = category[index];
                        return GestureDetector(
                            onTap: () {
                              Get.to(MealsDetails(
                                title: get.name,
                                imagePath: WebConfig.baseUrl +
                                    WebConfig.categoryImages +
                                    get.image,
                                categoryId: get.id,
                              ));
                            },
                            child: MealsCard(
                              title: get.name,
                              imagePath: WebConfig.baseUrl +
                                  WebConfig.categoryImages +
                                  get.image,
                            ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
