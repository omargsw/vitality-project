import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/model/get_date.dart';
import 'package:vitality/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleAppointments extends StatefulWidget {
  const ScheduleAppointments({Key? key}) : super(key: key);

  @override
  State<ScheduleAppointments> createState() => _ScheduleAppointmentsState();
}

class _ScheduleAppointmentsState extends State<ScheduleAppointments> {
  int? userId = sharedPreferences!.getInt('userID');
  bool isLoading = false;
  String? birthDate;
  DateRangePickerController datePickerController = DateRangePickerController();

  List<GetDate> dates = [];
  Future fetchDate() async {
    isLoading = true;
    try {
      String url =
          WebConfig.baseUrl + WebConfig.customerGetDate + "?center_id=$userId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetDate> list = getDateFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchDate] $e");
    } finally {
      isLoading = false;
    }
  }

  Future insertDate(
    var centerid,
    var datetime,
  ) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerAddDates;
      final response = await http.post(Uri.parse(url), body: {
        "center_id": centerid.toString(),
        "date_time": datetime.toString(),
      });
      log(response.body);
    } catch (e) {
      log("[insertDate] $e");
    }
  }

  Future deleteDate(var id) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.centerRemoveDate + "?id=$id";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[deleteDate] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    datePickerController.selectedDate =
        DateTime.now().add(const Duration(days: 0));
    fetchDate().then((list) {
      setState(() {
        dates = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Schedule Appointments", iconButton: null),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Select the date',
                        style: AppFonts.tajawal18BlackW500,
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: SfDateRangePicker(
                            view: DateRangePickerView.month,
                            selectionMode: DateRangePickerSelectionMode.single,
                            selectionColor: AppColors.primaryColor,
                            monthCellStyle: DateRangePickerMonthCellStyle(
                              blackoutDateTextStyle: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                              specialDatesTextStyle:
                                  const TextStyle(color: Colors.black),
                              cellDecoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              todayTextStyle:
                                  TextStyle(color: AppColors.secondaryColor),
                            ),
                            todayHighlightColor: AppColors.primaryColor,
                            controller: datePickerController,
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: const Text('Save'),
                              onPressed: () {
                                birthDate =
                                    "${datePickerController.selectedDate!.year}-${datePickerController.selectedDate!.month}-${datePickerController.selectedDate!.day}";
                                insertDate(userId, birthDate);
                                setState(() {
                                  fetchDate().then((list) {
                                    setState(() {
                                      dates = list;
                                    });
                                  });
                                });
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: PrimaryButton(
                title: "Open the calender",
                width: width * 0.8,
                backgroundcolor: AppColors.secondaryColor,
                height: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        GetDate get = dates[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(4, 1),
                                  blurRadius: 4,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    get.dateTime,
                                    style: AppFonts.tajawal18BlackW500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialogWidget(
                                                title:
                                                    "Are you sure to delete this date?",
                                                onTapYes: () {
                                                  deleteDate(get.id);
                                                  setState(() {
                                                    fetchDate().then((list) {
                                                      setState(() {
                                                        dates = list;
                                                      });
                                                    });
                                                  });
                                                  Get.back();
                                                },
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
        ],
      ),
    );
  }
}
