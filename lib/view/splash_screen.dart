import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/view/login_page.dart';
import 'package:vitality/widgets/primary_button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool time = false ;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3), () => time = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo.jpeg',
              height: 250,
              width: 250,
            ),
          ),
          const SizedBox(height: 180,),
              InkWell(
                onTap: () => Get.to(const LoginScreen(typeId: 1,)),
                child: PrimaryButton(title: "Login as customer",
                    width: width * 0.8, backgroundcolor: AppColors.primaryColor, height: 50),
              ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: () => Get.to(const LoginScreen(typeId: 2,)),
            child: PrimaryButton(title: "Login as center",
                width: width * 0.8, backgroundcolor: AppColors.secondaryColor, height: 50),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: () => Get.to(const LoginScreen(typeId: 3,)),
            child: PrimaryButton(title: "Login as admin",
                width: width * 0.8, backgroundcolor: AppColors.primaryColor, height: 50),
          ),
        ],
      ),
    );
  }
}