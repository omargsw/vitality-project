import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/widgets/primary_button.dart';

class CenterDetailsPage extends StatefulWidget {
  final String? image;
  final String? name;
  final String? email;
  final String? phone;
  const CenterDetailsPage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  }) : super(key: key);

  @override
  State<CenterDetailsPage> createState() => _CenterDetailsPageState();
}

class _CenterDetailsPageState extends State<CenterDetailsPage> {
  var selecteditem = null;
  var items = [
    '20/4/2022 11:00 AM',
    '22/4/2022 5:00 PM',
    '24/4/2022 6:30 PM',
    '25/4/2022 8:10 PM',
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Center Details", iconButton: null),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
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
                  child: Image.network(
                    WebConfig.baseUrl + WebConfig.centerImages + widget.image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 360,
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
                      child: Text(
                        "Name",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Text(
                      widget.name!,
                      style: AppFonts.tajawal14GreenW600,
                    ),
                    const Divider(
                      color: Colors.black54,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Phone Number",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Text(
                      widget.phone!,
                      style: AppFonts.tajawal14GreenW600,
                    ),
                    const Divider(
                      color: Colors.black54,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Email Address",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Text(
                      widget.email!,
                      style: AppFonts.tajawal14GreenW600,
                    ),
                    const Divider(
                      color: Colors.black54,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(1, 2))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 3, bottom: 3),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Choose the date",
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
                                  print(selecteditem);
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogWidget(
                                    title: "Are you sure about booking it?",
                                    onTapYes: () {});
                              });
                        },
                        child: PrimaryButton(
                            title: "Appointment Booking",
                            width: width * 0.7,
                            backgroundcolor: AppColors.secondaryColor,
                            height: 40)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
