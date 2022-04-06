import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'fonts.dart';

//This should be a functional widget since that the appBar parameter
//in scaffold only accepts it as a function.
AppBar mainAppBar({required String? title,required IconButton? iconButton}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed:() => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
          size: 25,
        ),
      ),
    ),
    title: Text(
      title!,
      style: AppFonts.tajawal25WhiteW600,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    actions: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: iconButton
      ),
    ],
    backgroundColor: AppColors.secondaryColor,
  );
}
