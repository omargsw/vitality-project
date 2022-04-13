import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:vitality/widgets/primary_button.dart';

class AdminNews extends StatefulWidget {
  const AdminNews({Key? key}) : super(key: key);

  @override
  State<AdminNews> createState() => _AdminNewsState();
}

class _AdminNewsState extends State<AdminNews> {
  TextEditingController desc = TextEditingController();
  bool _load = false;
  File ? imageFile;
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

  Future chooseImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = false;
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
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
          Get.to(const Addnews(title: "Add News",isName: false,));

        },
        child: const Icon(Icons.add,size: 30,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("News",style: AppFonts.tajawal20BlueW600,),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: image.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Stack(
                    children: [
                      Container(
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
                      ),
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialogWidget(title: "Are you sure to delete it?", onTapYes: (){});
                                      });
                                },
                                child: const IconButtonWidget(color: Colors.red, icons: Icons.delete)),
                                const SizedBox(height: 10,),
                                InkWell(
                                    onTap: (){
                                      Get.to(const Addnews(title: "Edit News",isName: false,));
                                    },
                                    child: IconButtonWidget(color: AppColors.primaryColor, icons: Icons.edit)),
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
