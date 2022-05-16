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
import 'package:vitality/view/nav_bar.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class EditNews extends StatefulWidget {
  final String? title;
  final int? id;
  final bool? isName;
  final String? type;
  final String? image;
  final String? titleNews;
  final String? desc;
  const EditNews({
    Key? key,
    required this.title,
    required this.id,
    required this.isName,
    required this.type,
    required this.image,
    required this.desc,
    required this.titleNews,
  }) : super(key: key);

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
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

  Future updateCategorydesc(var catid, var name) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminUpdateCategory;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "Cat_id": catid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateCategorydesc] $e");
    }
  }

  Future updateCategoryImage(var imageencoded, var image, var catid) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminUpdateCatImage;
      final response = await http.post(Uri.parse(url), body: {
        "image_encoded": imageencoded,
        "image": image,
        "Cat_id": catid.toString()
      });
      log(response.body);
    } catch (e) {
      log("[updateUserImageHandyMan] $e");
    }
  }

  Future updateNewsText(var title, var description, var advid) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminUpdateAdv;
      final response = await http.post(Uri.parse(url), body: {
        "title": title,
        "description": description,
        "Adv_id": advid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateNewsText] $e");
    }
  }

  Future updateNewsImage(var imageencoded, var image, var advid) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminUpdateAdvImage;
      final response = await http.post(Uri.parse(url), body: {
        "image_encoded": imageencoded,
        "image": image,
        "adv_id": advid.toString()
      });
      log(response.body);
    } catch (e) {
      log("[updateNewsImage] $e");
    }
  }

  Future updateFoodPlanText(var name, var description, var foodid) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerUpdateFoodPlan;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "description": description,
        "food_id": foodid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateFoodPlanText] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    title.text = widget.titleNews!;
    desc.text = widget.desc!;
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
                            ? Image.network(widget.image!)
                            : Image.file(File(imageFile!.path))),
                  ),
                  widget.type == 'food'
                      ? Container()
                      : Positioned(
                          bottom: 0.0,
                          top: 180,
                          right: 10.0,
                          child: Row(
                            children: [
                              imageFile == null
                                  ? InkWell(
                                      onTap: () async {
                                        chooseImage(ImageSource.gallery);
                                      },
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 30.0,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        base64image = base64Encode(
                                            imageFile!.readAsBytesSync());
                                        imagepath =
                                            imageFile!.path.split("/").last;
                                        if (widget.type == 'category') {
                                          updateCategoryImage(base64image,
                                              imagepath, widget.id);
                                        } else if (widget.type == 'news') {
                                          updateNewsImage(base64image,
                                              imagepath, widget.id);
                                        }
                                      },
                                      child: const Icon(
                                        Icons.done,
                                        color: Colors.green,
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
                  if (form.currentState!.validate()) {
                    if (widget.type == 'category') {
                      updateCategorydesc(widget.id, desc.text);
                      showDoneSnackBar(context, "Updated successfully");
                      Get.offAll(() => const NavBar(typeId: 3));
                    } else if (widget.type == 'news') {
                      updateNewsText(title.text, desc.text, widget.id);
                      showDoneSnackBar(context, "Updated successfully");
                      Get.offAll(() => const NavBar(typeId: 3));
                    } else if (widget.type == 'food') {
                      updateFoodPlanText(title.text, desc.text, widget.id);
                      showDoneSnackBar(context, "Updated successfully");
                      Get.offAll(() => const NavBar(typeId: 2));
                    }
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
