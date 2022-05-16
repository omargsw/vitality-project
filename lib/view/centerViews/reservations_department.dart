import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/components/text_field.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/model/appointments.dart';

class ReservationsDepartment extends StatefulWidget {
  const ReservationsDepartment({Key? key}) : super(key: key);

  @override
  State<ReservationsDepartment> createState() => _ReservationsDepartmentState();
}

class _ReservationsDepartmentState extends State<ReservationsDepartment> {
  int? userId = sharedPreferences!.getInt('userID');
  bool isLoading = false;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var fees = TextEditingController();

  List<GetAppointments> appointments = [];
  Future getAppointments() async {
    isLoading = true;
    try {
      String url =
          WebConfig.baseUrl + WebConfig.centerViewAppoimtments + "?id=$userId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetAppointments> list =
            getAppointmentsFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[getAppointments] $e");
    } finally {
      isLoading = false;
    }
  }

  Future centerAccpetAppointment(
    var appid,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerAccpetAppointment;
      final response = await http.post(Uri.parse(url), body: {
        "app_id": appid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertCategory] $e");
    }
  }

  Future centerRejectAppointment(
    var appid,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerRejectAppointment;
      final response = await http.post(Uri.parse(url), body: {
        "app_id": appid.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertCategory] $e");
    }
  }

  Future updateFees(
    var appid,
    var fees,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerUpdateFees;
      final response = await http.post(Uri.parse(url), body: {
        "app_id": appid.toString(),
        "fees": fees.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[updateFees] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getAppointments().then((list) {
      setState(() {
        appointments = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Reservations Department",
              style: AppFonts.tajawal20BlueW600,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      GetAppointments get = appointments[index];
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: width * 0.95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(4, 4),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name :  ",
                                            style: AppFonts.tajawal16GreenW600,
                                          ),
                                          Text(
                                            get.customerName,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Phone :  ",
                                            style: AppFonts.tajawal16GreenW600,
                                          ),
                                          Text(
                                            get.customerPhone,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                backgroundColor: Colors.white,
                                                content: SizedBox(
                                                  height: 200,
                                                  width: width,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 10, 20),
                                                        child: Center(
                                                          child: Text(
                                                              "Are you sure to accept this appointment?",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .primaryColor)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            "Enter the fees here",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppFonts
                                                                .tajawal14BlackW400),
                                                      ),
                                                      Form(
                                                        key: form,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child:
                                                              TextFieldWidget(
                                                            hintText:
                                                                "Enter the fees..",
                                                            prefixIcon:
                                                                const Icon(
                                                              Icons
                                                                  .attach_money_outlined,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            controller: fees,
                                                            suffixIconButton:
                                                                null,
                                                            ob: false,
                                                            type: "name",
                                                            inputType:
                                                                TextInputType
                                                                    .phone,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Cancel',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor,
                                                        )),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      if (form.currentState!
                                                          .validate()) {
                                                        centerAccpetAppointment(
                                                            get.id);
                                                        updateFees(
                                                            get.id, fees.text);
                                                        setState(() {
                                                          getAppointments()
                                                              .then((list) {
                                                            setState(() {
                                                              appointments =
                                                                  list;
                                                            });
                                                          });
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Text('Accept',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor,
                                                        )),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: const IconButtonWidget(
                                          color: Colors.green,
                                          icons: Icons.done)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialogWidget(
                                              title:
                                                  "Are you sure to reject the reservation?",
                                              onTapYes: () {
                                                centerRejectAppointment(get.id);
                                                setState(() {
                                                  getAppointments()
                                                      .then((list) {
                                                    setState(() {
                                                      appointments = list;
                                                    });
                                                  });
                                                });
                                                Get.back();
                                              },
                                            );
                                          });
                                    },
                                    child: const IconButtonWidget(
                                        color: Colors.red,
                                        icons: Icons.cancel_outlined),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
