import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vitality/components/app_bar_login.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/view/credit_card.dart';
import 'package:vitality/view/login_page.dart';
import 'package:vitality/view/question_page.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  bool ob = true;
  bool ob2 = true;
  Icon iconpass = const Icon(
    Icons.visibility,
    color: Colors.black,
  );
  Icon iconpass2 = const Icon(
    Icons.visibility,
    color: Colors.black,
  );
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  bool islogin = true;
  String? fromDate;
  String? endDate;

  DateRangePickerController datePickerController = DateRangePickerController();

  var selecteditem = null;
  var items = [
    'Month       25 JOD',
    '2 Month     45 JOD',
    '3 Month     60 JOD',
    '1 Year     99 JOD',
  ];

  Future<bool> userSignUp(var email, var pass, var phone, var name) async {
    String url = WebConfig.baseUrl + WebConfig.customerSignUp;
    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "email": email.toString(),
      "password": pass,
      "phone": phone,
    });
    var json = jsonDecode(response.body);
    if (json['error']) {
      showErrorSnackBar(context, "User already registered");
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt('userID', json['user']['id']);
      sharedPreferences.setString('name', json['user']['name']);
      sharedPreferences.setString('email', json['user']['email']);
      sharedPreferences.setString('phone', json['user']['phone']);
      sharedPreferences.setString('image', json['user']['image']);
      insertcustomerSubscription(
          sharedPreferences.getInt('userID'), fromDate, endDate);
      Get.to(const CreditCardPage());
    }
    return true;
  }

  Future insertcustomerSubscription(
    var customerid,
    var fromdate,
    var todate,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.customerSubscription;
      final response = await http.post(Uri.parse(url), body: {
        "customer_id": customerid.toString(),
        "from_date": fromdate.toString(),
        "to_date": todate.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertcustomerSubscription] $e");
    }
  }

  @override
  void initState() {
    datePickerController.selectedDate =
        DateTime.now().add(const Duration(days: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: mainAppBarLogin(title: "Sign Up", iconButton: null),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.jpeg',
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Create new account",
                  style: AppFonts.tajawal20BlueW600,
                ),
              ),
              Form(
                key: form,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      TextFieldWidget(
                        hint: "Enter you name",
                        text: "Name",
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
                        hint: "example@example.com",
                        text: "Email",
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
                        hint: "07xxxxxxxx",
                        text: "Phone number",
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
                      DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: Offset(1, 2))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 8, bottom: 8),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Select the subscription",
                                style: AppFonts.tajawal14BlackW400,
                              ),
                              isExpanded: true,
                              underline: Container(),
                              value: selecteditem,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                              ),
                              elevation: 16,
                              style: AppFonts.tajawal14BlackW400,
                              onChanged: (newValue) {
                                setState(() {
                                  selecteditem = newValue;
                                  if (selecteditem == "Month       25 JOD") {
                                    fromDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                    endDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month + 1}-${datePickerController.selectedDate!.day}";
                                  } else if (selecteditem ==
                                      "2 Month     45 JOD") {
                                    fromDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                    endDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month + 2}-${datePickerController.selectedDate!.day}";
                                  } else if (selecteditem ==
                                      "3 Month     60 JOD") {
                                    fromDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                    endDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month + 3}-${datePickerController.selectedDate!.day}";
                                  } else {
                                    fromDate =
                                        "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                    endDate =
                                        "${datePickerController.selectedDate!.year + 1}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                  }
                                });
                              },
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        hint: "",
                        text: "Password",
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
                                iconpass = const Icon(Icons.visibility_off,
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
                        hint: "",
                        text: "Confirm Password",
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
                                iconpass2 = const Icon(Icons.visibility_off,
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
                        type: "name",
                        inputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          if (form.currentState!.validate()) {
                            if (selecteditem != null) {
                              if (pass.text == pass2.text) {
                                userSignUp(email.text, pass2.text, phone.text,
                                    name.text);
                              } else {
                                showErrorSnackBar(
                                    context, "Password doesn't match!");
                              }
                            } else {
                              showErrorSnackBar(
                                  context, "You must select the subscription");
                            }
                          }
                        },
                        child: PrimaryButton(
                            title: "SignUp",
                            width: width * 0.8,
                            backgroundcolor: AppColors.secondaryColor,
                            height: 50),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
