import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/widgets/primary_button.dart';

class CenterDetailsPage extends StatefulWidget {
  const CenterDetailsPage({Key? key}) : super(key: key);

  @override
  State<CenterDetailsPage> createState() => _CenterDetailsPageState();
}

class _CenterDetailsPageState extends State<CenterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Center Details", iconButton: null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset('assets/images/logo.jpeg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),

              ),
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            height: 300,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Name",style: AppFonts.tajawal20BlueW600,),
                ),
                Text("Name",style: AppFonts.tajawal14GreenW600,),
                const Divider(
                  color: Colors.black54,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Phone Number",style: AppFonts.tajawal20BlueW600,),
                ),
                Text("phone",style: AppFonts.tajawal14GreenW600,),
                const Divider(
                  color: Colors.black54,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Email Address",style: AppFonts.tajawal20BlueW600,),
                ),
                Text("email",style: AppFonts.tajawal14GreenW600,),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogWidget(title: "Are you sure about booking it?", onTapYes: (){});
                        });
                  },
                    child: PrimaryButton(
                        title: "Appointment Booking",
                        width: width * 0.7,
                        backgroundcolor: AppColors.secondaryColor,
                        height: 40)),
              ],
            )
          ),
        ],
      ),
    );
  }
}

