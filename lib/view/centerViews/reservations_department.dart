import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:http/http.dart' as http;
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
                                              return AlertDialogWidget(
                                                  title:
                                                      "Are you sure to accept the reservation?",
                                                  onTapYes: () {});
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
                                                onTapYes: () {});
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
