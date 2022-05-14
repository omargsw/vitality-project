import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/centers.dart';
import 'package:vitality/view/center_details.dart';
import 'package:http/http.dart' as http;

class CentersPage extends StatefulWidget {
  const CentersPage({Key? key}) : super(key: key);

  @override
  State<CentersPage> createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  bool isLoading = false;

  List<GetCenter> centers = [];
  Future fetchCenter() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.getCenter;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetCenter> list = getCenterFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchCenter] $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCenter().then((list) {
      setState(() {
        centers = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Slimming centers",
                style: AppFonts.tajawal20BlueW600,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 2.85,
                ),
                itemCount: centers.length,
                itemBuilder: (_, index) {
                  GetCenter get = centers[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(CenterDetailsPage(
                        name: get.name,
                        email: get.email,
                        phone: get.phone,
                        image: get.image,
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
                                  WebConfig.baseUrl +
                                      WebConfig.centerImages +
                                      get.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                width: width,
                                padding: const EdgeInsets.all(5),
                                color: Colors.white,
                                child: Text(
                                  get.name,
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
          ],
        ),
      ),
    );
  }
}
