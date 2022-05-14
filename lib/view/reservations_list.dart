import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/model/appointments.dart';

class ReservationsList extends StatefulWidget {
  const ReservationsList({Key? key}) : super(key: key);

  @override
  State<ReservationsList> createState() => _ReservationsListState();
}

class _ReservationsListState extends State<ReservationsList> {
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
      body: isLoading
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
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                "Center name :  ",
                                style: AppFonts.tajawal16GreenW600,
                              ),
                              Text(
                                get.centerName,
                                style: AppFonts.tajawal14BlackW400,
                              ),
                            ],
                          ),
                          trailing: Text(
                            get.status,
                            style: AppFonts.tajawal14BlackW400,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
