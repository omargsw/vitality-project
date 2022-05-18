import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/app_bar_login.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/constant.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/text_field.dart';
import 'package:vitality/view/nav_bar.dart';
import 'package:vitality/widgets/primary_button.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

enum SingingCharacter { male, female }
enum SingingCharacteryesonno { yes, no }
enum SingingCharacteryesonno2 { yes, no }
enum SingingCharactergood { good, bad, others }

class _QuestionPageState extends State<QuestionPage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  SingingCharacter? character = null;
  SingingCharacteryesonno? character2 = null;
  SingingCharacteryesonno2? character3 = null;
  SingingCharactergood? character4 = null;
  var q1 = TextEditingController();
  var q2 = TextEditingController();
  var q3 = TextEditingController();
  var q4 = TextEditingController();
  var q5 = TextEditingController();
  var q6 = TextEditingController();
  var q7 = TextEditingController();
  var q8 = TextEditingController();
  bool isYes = false;
  bool isYes2 = false;

  var selecteditem1 = null;
  var selecteditem2 = null;
  var selecteditem3 = null;
  var items = [
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
  ];

  var height = [
    '140 cm',
    '141 cm',
    '142 cm',
    '143 cm',
    '144 cm',
    '145 cm',
    '146 cm',
    '147 cm',
    '148 cm',
    '149 cm',
    '151 cm',
    '152 cm',
    '153 cm',
    '154 cm',
    '155 cm',
    '156 cm',
    '157 cm',
    '158 cm',
    '159 cm',
    '160 cm',
    '161 cm',
    '162 cm',
    '163 cm',
    '164 cm',
    '165 cm',
    '166 cm',
    '167 cm',
    '168 cm',
    '169 cm',
    '170 cm',
    '171 cm',
    '172 cm',
    '173 cm',
    '174 cm',
    '175 cm',
    '176 cm',
    '177 cm',
    '178 cm',
    '179 cm',
  ];

  var weight = [
    '50 k',
    '51 k',
    '52 k',
    '53 k',
    '54 k',
    '55 k',
    '56 k',
    '57 k',
    '58 k',
    '59 k',
    '60 k',
    '61 k',
    '62 k',
    '63 k',
    '64 k',
    '65 k',
    '66 k',
    '67 k',
    '68 k',
    '69 k',
    '70 k',
    '71 k',
    '72 k',
    '73 k',
    '74 k',
    '75 k',
    '76 k',
    '77 k',
    '78 k',
    '79 k',
    '80 k',
    '80 k',
    '81 k',
    '82 k',
    '83 k',
    '84 k',
    '85 k',
    '86 k',
    '87 k',
    '88 k',
    '89 k',
    '90 k',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: mainAppBarLogin(title: "Question page", iconButton: null),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "City",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: "Name of city..",
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Colors.black,
                    ),
                    controller: q1,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Gender",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.male,
                            groupValue: character,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                character = value;
                              });
                            },
                          ),
                          const Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.female,
                            groupValue: character,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                character = value;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Age",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DecoratedBox(
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
                              left: 20,
                              right: 20,
                            ),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Your age",
                                style: AppFonts.tajawal14BlackW400,
                              ),
                              underline: Container(),
                              value: selecteditem1,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                              ),
                              elevation: 16,
                              style: AppFonts.tajawal14BlackW400,
                              onChanged: (newValue) {
                                setState(() {
                                  selecteditem1 = newValue;
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Height",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DecoratedBox(
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
                              left: 20,
                              right: 20,
                            ),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Your height",
                                style: AppFonts.tajawal14BlackW400,
                              ),
                              underline: Container(),
                              value: selecteditem2,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                              ),
                              elevation: 16,
                              style: AppFonts.tajawal14BlackW400,
                              onChanged: (newValue) {
                                setState(() {
                                  selecteditem2 = newValue;
                                });
                              },
                              items: height.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Weight",
                        style: AppFonts.tajawal20BlueW600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DecoratedBox(
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
                              left: 20,
                              right: 20,
                            ),
                            child: DropdownButton<String>(
                              hint: Text(
                                "Your weight",
                                style: AppFonts.tajawal14BlackW400,
                              ),
                              underline: Container(),
                              value: selecteditem3,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                              ),
                              elevation: 16,
                              style: AppFonts.tajawal14BlackW400,
                              onChanged: (newValue) {
                                setState(() {
                                  selecteditem3 = newValue;
                                });
                              },
                              items: weight.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Is this your first time doing diet, if yes what is it?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<SingingCharacteryesonno>(
                            value: SingingCharacteryesonno.yes,
                            groupValue: character2,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacteryesonno? value) {
                              setState(() {
                                character2 = value;
                                isYes = true;
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharacteryesonno>(
                            value: SingingCharacteryesonno.no,
                            groupValue: character2,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacteryesonno? value) {
                              setState(() {
                                character2 = value;
                                isYes = false;
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  ),
                ),
                isYes
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFieldWidget(
                          hintText: "Why yes..",
                          prefixIcon: null,
                          controller: q2,
                          suffixIconButton: null,
                          ob: false,
                          type: "name",
                          inputType: TextInputType.name,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "How many hours do you work and sleep?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: ".....",
                    prefixIcon: null,
                    controller: q3,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Do you use any medical supplements, if yes what is it?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<SingingCharacteryesonno2>(
                            value: SingingCharacteryesonno2.yes,
                            groupValue: character3,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacteryesonno2? value) {
                              setState(() {
                                character3 = value;
                                isYes2 = true;
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharacteryesonno2>(
                            value: SingingCharacteryesonno2.no,
                            groupValue: character3,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharacteryesonno2? value) {
                              setState(() {
                                character3 = value;
                                isYes2 = false;
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  ),
                ),
                isYes2
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFieldWidget(
                          hintText: "Why yes..",
                          prefixIcon: null,
                          controller: q8,
                          suffixIconButton: null,
                          ob: false,
                          type: "name",
                          inputType: TextInputType.name,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Any Food allergies?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: ".....",
                    prefixIcon: null,
                    controller: q4,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "How is your physical activity:",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<SingingCharactergood>(
                            value: SingingCharactergood.good,
                            groupValue: character4,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharactergood? value) {
                              setState(() {
                                character4 = value;
                              });
                            },
                          ),
                          const Text('Good'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharactergood>(
                            value: SingingCharactergood.bad,
                            groupValue: character4,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharactergood? value) {
                              setState(() {
                                character4 = value;
                              });
                            },
                          ),
                          const Text('Bad'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharactergood>(
                            value: SingingCharactergood.others,
                            groupValue: character4,
                            activeColor: AppColors.primaryColor,
                            onChanged: (SingingCharactergood? value) {
                              setState(() {
                                character4 = value;
                              });
                            },
                          ),
                          const Text('Others'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "How many days do you work out?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: ".....",
                    prefixIcon: null,
                    controller: q5,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "What kind of food you usually have for breakfast , lunch and dinner?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: ".....",
                    prefixIcon: null,
                    controller: q6,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "How many times do you eat fast food per week?",
                    style: AppFonts.tajawal20BlueW600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFieldWidget(
                    hintText: ".....",
                    prefixIcon: null,
                    controller: q7,
                    suffixIconButton: null,
                    ob: false,
                    type: "name",
                    inputType: TextInputType.name,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (form.currentState!.validate()) {
                        if (selecteditem1 == null &&
                            selecteditem2 == null &&
                            selecteditem3 == null &&
                            character == null &&
                            character2 == null &&
                            character3 == null &&
                            character4 == null) {
                          showErrorSnackBar(
                              context, "You have to answer all the questions");
                        } else {
                          Get.to(const NavBar(typeId: 1));
                          showAlertDialog(context);
                        }
                      }
                    },
                    child: PrimaryButton(
                        title: "Continue",
                        width: width * 0.8,
                        backgroundcolor: AppColors.secondaryColor,
                        height: 50),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
