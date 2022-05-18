import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/appointments.dart';

class AdminReservations extends StatefulWidget {
  const AdminReservations({Key? key}) : super(key: key);

  @override
  State<AdminReservations> createState() => _AdminReservationsState();
}

class _AdminReservationsState extends State<AdminReservations> {
  bool isLoading = false;

  List<GetAppointments> appointments = [];
  Future getAppointments() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.adminGetAppointments;
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      children: [
                                        Text(
                                          get.status,
                                          style: AppFonts.tajawal16GreenW600,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Customer name :  ",
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
                                            "Customer phone :  ",
                                            style: AppFonts.tajawal16GreenW600,
                                          ),
                                          Text(
                                            get.centerPhone,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Center name :  ",
                                            style: AppFonts.tajawal14BlueW600,
                                          ),
                                          Text(
                                            get.centerName,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Center phone :  ",
                                            style: AppFonts.tajawal14BlueW600,
                                          ),
                                          Text(
                                            get.centerPhone,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Fees :  ",
                                            style: AppFonts.tajawal14BlueW600,
                                          ),
                                          Text(
                                            get.fees.toString(),
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Time :  ",
                                            style: AppFonts.tajawal14BlueW600,
                                          ),
                                          Text(
                                            get.time,
                                            style: AppFonts.tajawal14BlackW400,
                                          ),
                                        ],
                                      ),
                                    ],
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
