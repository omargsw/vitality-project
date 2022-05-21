import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitality/components/app_bar_login.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/view/nav_bar.dart';
import 'package:vitality/view/signup_page.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final int typeId;
  const LoginScreen({Key? key, required this.typeId}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  bool ob = true;
  Icon iconpass = const Icon(
    Icons.visibility,
    color: Colors.black,
  );
  var email = TextEditingController();
  var pass = TextEditingController();
  bool islogin = true;
  bool isLoading = false;

  Future customerLoginIn(var email, var pass) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = WebConfig.baseUrl + WebConfig.customerLogin;
      final response = await http.post(Uri.parse(url), body: {
        "email": email.toString(),
        "password": pass,
      });
      var json = jsonDecode(response.body);
      if (json['error']) {
        showErrorSnackBar(context, "Incorrect email or password");
        setState(() {
          isLoading = false;
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('userID', json['user']['id']);
        sharedPreferences.setString('name', json['user']['name']);
        sharedPreferences.setString('email', json['user']['email']);
        sharedPreferences.setString('phone', json['user']['phone']);
        sharedPreferences.setString('image', json['user']['image']);
        Get.offAll(NavBar(typeId: widget.typeId));
      }
      return true;
    } catch (e) {
      log("[userLoginIn] : $e");
    } finally {
      isLoading = false;
    }
  }

  Future centerLoginIn(var email, var pass) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = WebConfig.baseUrl + WebConfig.centerLogin;
      final response = await http.post(Uri.parse(url), body: {
        "email": email.toString(),
        "password": pass,
      });
      var json = jsonDecode(response.body);
      if (json['error']) {
        showErrorSnackBar(context, "Incorrect email or password");
        setState(() {
          isLoading = false;
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('userID', json['user']['id']);
        sharedPreferences.setString('name', json['user']['name']);
        sharedPreferences.setString('email', json['user']['email']);
        sharedPreferences.setString('phone', json['user']['phone']);
        sharedPreferences.setString('image', json['user']['image']);
        Get.offAll(NavBar(typeId: widget.typeId));
      }
      return true;
    } catch (e) {
      log("[centerLoginIn] : $e");
    } finally {
      isLoading = false;
    }
  }

  Future adminLoginIn(var email, var pass) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = WebConfig.baseUrl + WebConfig.adminLogin;
      final response = await http.post(Uri.parse(url), body: {
        "email": email.toString(),
        "password": pass,
      });
      var json = jsonDecode(response.body);
      if (json['error']) {
        showErrorSnackBar(context, "Incorrect email or password");
        setState(() {
          isLoading = false;
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('userID', json['user']['id']);
        sharedPreferences.setString('name', json['user']['name']);
        sharedPreferences.setString('email', json['user']['email']);
        Get.offAll(NavBar(typeId: widget.typeId));
      }
      return true;
    } catch (e) {
      log("[userLoginIn] : $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: mainAppBarLogin(title: "Login", iconButton: null),
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
                  "Welcome Back",
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
                          hint: "",
                          text: "Email..",
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          suffixIconButton: null,
                          ob: false,
                          type: "email"),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          hint: "",
                          text: "Password..",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          controller: pass,
                          inputType: TextInputType.visiblePassword,
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
                          type: "pass"),
                      const SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondaryColor,
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setInt('typeID', widget.typeId);
                          int? typeId = sharedPreferences.getInt('typeID');
                          if (widget.typeId == 1) {
                            customerLoginIn(email.text, pass.text);
                          } else if (widget.typeId == 2) {
                            centerLoginIn(email.text, pass.text);
                          } else {
                            adminLoginIn(email.text, pass.text);
                          }
                        },
                        child: PrimaryButton(
                            title: "Login",
                            width: width * 0.8,
                            backgroundcolor: AppColors.secondaryColor,
                            height: 50),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.typeId == 1
                          ? InkWell(
                              onTap: () => Get.to(const SignUpPage()),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Don't have account?",
                                      style: AppFonts.tajawal18BlackW500,
                                      children: [
                                        TextSpan(
                                          text: " Sign up",
                                          style: AppFonts
                                              .tajawal20BlueW600Underline,
                                        )
                                      ]),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
