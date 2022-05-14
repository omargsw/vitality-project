import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/advertisment.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/view/adminViews/edit_news.dart';

class AdminNews extends StatefulWidget {
  const AdminNews({Key? key}) : super(key: key);

  @override
  State<AdminNews> createState() => _AdminNewsState();
}

class _AdminNewsState extends State<AdminNews> {
  TextEditingController desc = TextEditingController();
  bool isLoading = false;
  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';

  List image = [
    "assets/images/lunch.jpg",
    "assets/images/lunch.jpg",
    "assets/images/lunch.jpg",
    "assets/images/dinner.jpg"
  ];

  List text = [
    "one",
    "one",
    "one",
    "two",
  ];

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

  Future deleteNews(var newsId) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminRemovAdv + "?id=$newsId";
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(const Addnews(
            title: "Add News",
            isName: true,
            type: 'news',
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
              "News",
              style: AppFonts.tajawal20BlueW600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: advertisments.length,
                    itemBuilder: (context, index) {
                      GetAdvertisment get = advertisments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
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
                                              bottomRight:
                                                  Radius.circular(10.0),
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
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        get.description,
                                                        style: AppFonts
                                                            .tajawal20BlueW600,
                                                        textAlign:
                                                            TextAlign.center,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialogWidget(
                                                    title:
                                                        "Are you sure to delete it?",
                                                    onTapYes: () {
                                                      deleteNews(get.id);
                                                      setState(() {
                                                        fetchAdvertisment()
                                                            .then((list) {
                                                          setState(() {
                                                            advertisments =
                                                                list;
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
                                      height: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.to(EditNews(
                                            title: 'Edit News',
                                            isName: true,
                                            type: 'news',
                                            image: WebConfig.baseUrl +
                                                WebConfig.advImages +
                                                get.image,
                                            titleNews: get.title,
                                            desc: get.description,
                                            id: get.id,
                                          ));
                                        },
                                        child: IconButtonWidget(
                                            color: AppColors.primaryColor,
                                            icons: Icons.edit)),
                                  ],
                                ),
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
