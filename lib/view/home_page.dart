import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/meals_card.dart';
import 'package:vitality/view/meals_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List image = [
    "assets/images/lunch.jpg",
    "assets/images/dinner.jpg"
  ];

  List text = [
    "one",
    "two",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("News",style: AppFonts.tajawal20BlueW600,),
            ),
            const SizedBox(height: 10,),
            CarouselSlider.builder(
              itemCount: image.length,
              itemBuilder: (context, index, realIndex) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius:  BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                                decoration: const BoxDecoration(
                                  borderRadius:  BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  color: const Color(0xffD5D8D9),

                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                text[index]+"asdasd asd asd asdasd asd ",
                                                style: AppFonts.tajawal20BlueW600,
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
              child: Text("Daily meals",style: AppFonts.tajawal20BlueW600,),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(const MealsDetails(title: "Breakfast",imagePath: 'assets/images/breakfast.jpg',));
                        },
                        child: const MealsCard(title: "Breakfast",imagePath: 'assets/images/breakfast.jpg',)
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(const MealsDetails(title: "Lunch",imagePath: 'assets/images/lunch.jpg',));
                        },
                        child: const MealsCard(title: "Lunch",imagePath: 'assets/images/lunch.jpg',)
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(const MealsDetails(title: "Dinner",imagePath: 'assets/images/dinner.jpg',));
                        },
                        child: const MealsCard(title: "Dinner",imagePath: 'assets/images/dinner.jpg',)
                    ),
                  ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
