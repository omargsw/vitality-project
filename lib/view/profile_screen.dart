import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/view/centerViews/center_schedule_appointments.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? typeId = sharedPreferences!.getInt('typeID');
  int? userId = sharedPreferences!.getInt('userID');
  String? profileimage = sharedPreferences!.getString('image');
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var pass2 = TextEditingController();
  var desc = TextEditingController();
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

  Future updateCustomerAccount(
      var customerid, var email, var name, var phone, var password) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.customerUpdateInfo;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "customer_id": customerid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateAccount] $e");
    }
  }

  Future updateCustomerImage(
      var customerid, var image, var profileDecoded) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.customerUpdateImage;
      final response = await http.post(Uri.parse(url), body: {
        "customer_id": customerid.toString(),
        "image": image.toString(),
        "image_encoded": profileDecoded.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateUserImage] $e");
    }
  }

  Future updateCenterAccount(var centerid, var email, var name, var phone,
      var password, var description) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerUpdateInfo;
      final response = await http.post(Uri.parse(url), body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "description": description,
        "center_id": centerid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateAccount] $e");
    }
  }

  Future updateCenterImage(var centerid, var image, var profileDecoded) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerUpdateImage;
      final response = await http.post(Uri.parse(url), body: {
        "center_id": centerid.toString(),
        "image": image.toString(),
        "image_encoded": profileDecoded.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateUserImage] $e");
    }
  }

  @override
  void initState() {
    typeId = sharedPreferences!.getInt('typeID');
    print(typeId);
    name.text = sharedPreferences!.getString('name')!;
    email.text = sharedPreferences!.getString('email')!;
    phone.text = sharedPreferences!.getString('phone')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: typeId == 2
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: Colors.white,
              onPressed: () => Get.to(const ScheduleAppointments()),
              icon: const Icon(Icons.add),
              label: const Text('Add a dates'),
            )
          : Container(),
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
                                child: Image.network(
                                  typeId == 1
                                      ? WebConfig.baseUrl +
                                          WebConfig.customerImage +
                                          profileimage.toString()
                                      : WebConfig.baseUrl +
                                          WebConfig.centerImages +
                                          profileimage.toString(),
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
                                : Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          chooseImage(ImageSource.gallery);
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () async {
                                            if (imageFile == null) return;
                                            photo = base64Encode(
                                                imageFile!.readAsBytesSync());
                                            imagepath =
                                                imageFile!.path.split("/").last;
                                            if (typeId == 1) {
                                              updateCustomerImage(
                                                  userId, imagepath, photo);
                                            } else {
                                              updateCenterImage(
                                                  userId, imagepath, photo);
                                            }
                                            imageCache!.clear();
                                          },
                                          child: const Icon(
                                            Icons.done,
                                            color:
                                                Color.fromARGB(250, 9, 85, 245),
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                              typeId == 2
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    blurRadius: 20,
                                                    offset: Offset(1, 2))
                                              ]),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              maxLines: 3,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                labelText: "Description..",
                                                labelStyle:
                                                    AppFonts.tajawal14BlackW400,
                                                fillColor: Colors.white,
                                                focusColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
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
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
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
                                    if (typeId == 1) {
                                      if (pass.text == pass2.text) {
                                        updateCustomerAccount(
                                          userId,
                                          email.text,
                                          name.text,
                                          phone.text,
                                          pass2.text,
                                        );
                                        showDoneSnackBar(
                                            context, "Updated Successfully");
                                      } else {
                                        showErrorSnackBar(
                                            context, "Password doesn't match!");
                                      }
                                    } else {
                                      if (pass.text == pass2.text) {
                                        updateCenterAccount(
                                            userId,
                                            email.text,
                                            name.text,
                                            phone.text,
                                            desc.text,
                                            pass2.text);
                                        showDoneSnackBar(
                                            context, "Updated Successfully");
                                      } else {
                                        showErrorSnackBar(
                                            context, "Password doesn't match!");
                                      }
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
