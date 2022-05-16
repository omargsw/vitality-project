import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/widgets/primary_button.dart';

class AddCenterAccount extends StatefulWidget {
  const AddCenterAccount({Key? key}) : super(key: key);

  @override
  State<AddCenterAccount> createState() => _AddCenterAccountState();
}

class _AddCenterAccountState extends State<AddCenterAccount> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var location = TextEditingController();
  var stname = TextEditingController();
  var desc = TextEditingController();
  var pass = TextEditingController();
  var pass2 = TextEditingController();
  var pass3 = TextEditingController();
  bool ob = true, ob2 = true, ob3 = true;
  var confpass;
  Icon iconpass = Icon(Icons.visibility, color: AppColors.primaryColor);
  Icon iconpass2 = Icon(
    Icons.visibility,
    color: AppColors.primaryColor,
  );
  Icon iconpass3 = Icon(
    Icons.visibility,
    color: AppColors.primaryColor,
  );

  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';

  void _showDoneSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.done_outline,
            size: 20,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.green),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black45,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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

  Future insertCenter(
    var name,
    var email,
    var phone,
    var password,
    var image,
    var imagedecoded,
    var location,
    var streetname,
    var description,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.addCenter;
      final response = await http.post(Uri.parse(url), body: {
        "name": name.toString(),
        "email": email.toString(),
        "phone": phone.toString(),
        "password": password.toString(),
        "image": image.toString(),
        "imagedecoded": imagedecoded.toString(),
        "location": location.toString(),
        "street_name": streetname.toString(),
        "description": description.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertCenter] $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Add center account", iconButton: null),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Center(
                    child: Stack(children: <Widget>[
                      imageFile == null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/nouserimage.jpg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    FileImage(File(imageFile!.path)),
                              ),
                            ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Row(
                          children: [
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
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Form(
                        key: form,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextFieldWidget(
                                hintText: "Name..",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                controller: name,
                                suffixIconButton: null,
                                ob: false,
                                type: "name",
                                inputType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Email..",
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                controller: email,
                                suffixIconButton: null,
                                ob: false,
                                type: "email",
                                inputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Phone number..",
                                prefixIcon: const Icon(
                                  Icons.phone_android,
                                  color: Colors.black,
                                ),
                                controller: phone,
                                suffixIconButton: null,
                                ob: false,
                                type: "phone",
                                inputType: TextInputType.phone,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Location..",
                                prefixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                controller: location,
                                suffixIconButton: null,
                                ob: false,
                                type: "name",
                                inputType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Street Name..",
                                prefixIcon: const Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                ),
                                controller: stname,
                                suffixIconButton: null,
                                ob: false,
                                type: "name",
                                inputType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 20,
                                          offset: Offset(1, 2))
                                    ]),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    maxLines: 3,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      labelText: "Description..",
                                      labelStyle: AppFonts.tajawal14BlackW400,
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.text_snippet_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required";
                                      }
                                      return null;
                                    },
                                    controller: desc,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Password..",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                controller: pass,
                                suffixIconButton: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ob == true) {
                                        ob = false;
                                        iconpass = const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black);
                                      } else {
                                        ob = true;
                                        iconpass = const Icon(Icons.visibility,
                                            color: Colors.black);
                                      }
                                    });
                                  },
                                  icon: iconpass,
                                ),
                                ob: ob,
                                type: "pass",
                                inputType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                hintText: "Confirm Password..",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                controller: pass2,
                                suffixIconButton: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ob2 == true) {
                                        ob2 = false;
                                        iconpass2 = const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black);
                                      } else {
                                        ob2 = true;
                                        iconpass2 = const Icon(Icons.visibility,
                                            color: Colors.black);
                                      }
                                    });
                                  },
                                  icon: iconpass2,
                                ),
                                ob: ob2,
                                type: "pass",
                                inputType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  if (form.currentState!.validate()) {
                                    if (imageFile != null) {
                                      if (pass.text == pass2.text) {
                                        photo = base64Encode(
                                            imageFile!.readAsBytesSync());
                                        imagepath =
                                            imageFile!.path.split("/").last;
                                        insertCenter(
                                          name.text,
                                          email.text,
                                          phone.text,
                                          pass2.text,
                                          imageFile,
                                          photo,
                                          location.text,
                                          stname.text,
                                          desc.text,
                                        );
                                        showDoneSnackBar(
                                            context, "Added Successfully");
                                        imageFile == null;
                                        name.clear();
                                        email.clear();
                                        phone.clear();
                                        pass.clear();
                                        pass2.clear();
                                        location.clear();
                                        stname.clear();
                                        desc.clear();
                                      } else {
                                        showErrorSnackBar(
                                            context, "Password doesn't match!");
                                      }
                                    } else {
                                      showErrorSnackBar(context,
                                          "You must upload account picture");
                                    }
                                  }
                                },
                                child: PrimaryButton(
                                  title: "SAVE",
                                  width: width * 0.7,
                                  backgroundcolor: AppColors.secondaryColor,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
