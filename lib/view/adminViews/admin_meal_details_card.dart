import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/view/adminViews/add_news.dart';
import 'package:vitality/widgets/primary_button.dart';

class MealDetailsCardAdmin extends StatefulWidget {
  final String? title;
  final String? imagePath;
  const MealDetailsCardAdmin({Key? key,required this.title,required this.imagePath}) : super(key: key);

  @override
  State<MealDetailsCardAdmin> createState() => _MealDetailsCardAdminState();
}

class _MealDetailsCardAdminState extends State<MealDetailsCardAdmin> {
  GlobalKey<FormState> form= GlobalKey<FormState>();
  var name=TextEditingController();
  var phone=TextEditingController();
  var email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: mainAppBar(title: widget.title, iconButton: null),
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 250,
                width: width * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "asdasd asdklasd asdjhasdkj asjdhasjkd asdasd asd asd asdasd asd ",
                      style: AppFonts.tajawal20WhiteW600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
            const SizedBox(height: 30,),
            InkWell(
                onTap: (){
                  Get.to(const Addnews(title: "Edit Categories",isName: true,));
                },
                child: PrimaryButton(title: "Edit", width: width * 0.5, backgroundcolor: AppColors.primaryColor, height: 50)),
          ],
        ),

      ),
    );
  }
}
