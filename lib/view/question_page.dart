import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/app_bar_login.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/view/nav_bar.dart';
import 'package:vitality/widgets/primary_button.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}
enum SingingCharacter { male, female }
class _QuestionPageState extends State<QuestionPage> {
  SingingCharacter? character = SingingCharacter.male;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBarLogin(title: "Question page", iconButton: null),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Gender",style: AppFonts.tajawal20BlueW600,),
          ),
          ListTile(
            title: const Text('Male'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.male,
              groupValue: character,
              activeColor: AppColors.primaryColor,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Female'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.female,
              groupValue: character,
              activeColor: AppColors.primaryColor,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  character = value;
                });
              },
            ),
          ),
          Spacer(),
          Center(
            child: InkWell(
              onTap: () => Get.to(const NavBar(typeId: 1,)),
              child: PrimaryButton(title: "Continue",
                  width: width*0.8,
                  backgroundcolor: AppColors.secondaryColor
                  , height: 50),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      )
    );
  }
}
