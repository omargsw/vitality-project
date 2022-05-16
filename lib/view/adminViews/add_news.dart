import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/view/nav_bar.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class Addnews extends StatefulWidget {
  final String? title;
  final int? newsId;
  final bool? isName;
  final String? type;
  const Addnews({
    Key? key,
    required this.title,
    this.newsId,
    required this.isName,
    required this.type,
  }) : super(key: key);

  @override
  State<Addnews> createState() => _AddnewsState();
}

class _AddnewsState extends State<Addnews> {
  int? userId = sharedPreferences!.getInt('userID');
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String base64image = '';
  String imagepath = '';

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

  Future insertCategory(
    var name,
    var image,
    var imagedecoded,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminAddCategory;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "image": image,
        "imagedecoded": imagedecoded,
      });
      log(response.body);
    } catch (e) {
      log("[insertCategory] $e");
    }
  }

  Future insertFood(
    var name,
    var description,
    var centersid,
    var categoryid,
    var image,
    var imagedecoded,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerAddFood;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "description": description,
        "category_id": categoryid.toString(),
        "image": image,
        "imagedecoded": imagedecoded,
        "centers_id": centersid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertFood] $e");
    }
  }

  Future insertNews(
    var title,
    var description,
    var image,
    var imagedecoded,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.addAdvertisment;
      final response = await http.post(Uri.parse(url), body: {
        "title": title,
        "description": description,
        "image": image,
        "imagedecoded": imagedecoded,
      });
      log(response.body);
    } catch (e) {
      log("[insertNews] $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: widget.title, iconButton: null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Center(
                    child: SizedBox(
                        width: 300,
                        height: 200,
                        child: imageFile == null
                            ? Image.asset('assets/images/noimage.png')
                            : Image.file(File(imageFile!.path))),
                  ),
                  Positioned(
                    bottom: 0.0,
                    top: 180,
                    right: 10.0,
                    child: Row(
                      children: [
                        //imageFile == null ?
                        InkWell(
                          onTap: () async {
                            chooseImage(ImageSource.gallery);
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    widget.isName!
                        ? TextFieldWidget(
                            hintText: "Title",
                            prefixIcon: null,
                            controller: title,
                            suffixIconButton: null,
                            ob: false,
                            type: "name",
                            inputType: TextInputType.name,
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: "Description",
                      prefixIcon: null,
                      controller: desc,
                      suffixIconButton: null,
                      ob: false,
                      type: "name",
                      inputType: TextInputType.name,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: InkWell(
                onTap: () {
                  // int? userId = sharedPreferences!.getInt('userID');
                  base64image = base64Encode(imageFile!.readAsBytesSync());
                  imagepath = imageFile!.path.split("/").last;
                  if (imageFile != null) {
                    if (form.currentState!.validate()) {
                      if (widget.type == 'category') {
                        insertCategory(desc.text, imagepath, base64image);
                        Get.offAll(() => const NavBar(typeId: 3));
                      } else if (widget.type == 'news') {
                        insertNews(
                            title.text, desc.text, imagepath, base64image);
                        Get.offAll(() => const NavBar(typeId: 3));
                      } else if (widget.type == 'food') {
                        insertFood(title.text, desc.text, userId, widget.newsId,
                            imagepath, base64image);
                        Get.offAll(() => const NavBar(typeId: 2));
                      }

                      showDoneSnackBar(context, "Added Successfully");
                    }
                  } else {
                    showErrorSnackBar(context, "You must upload image");
                  }
                },
                child: PrimaryButton(
                  title: 'SAVE',
                  backgroundcolor: AppColors.primaryColor,
                  width: width * 0.5,
                  height: 50,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
