import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';

class AdminReservations extends StatefulWidget {
  const AdminReservations({Key? key}) : super(key: key);

  @override
  State<AdminReservations> createState() => _AdminReservationsState();
}

class _AdminReservationsState extends State<AdminReservations> {
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
            child: Text("Reservations Department",style: AppFonts.tajawal20BlueW600,),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      width: width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                            const SizedBox(width: 8,),
                            ClipOval(
                              child: Image.asset('assets/images/logo.jpeg',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("name",style: AppFonts.tajawal16GreenW600,),
                                Text("Phone",style: AppFonts.tajawal14BlueW600,),
                                Text("Book at center :",style: AppFonts.tajawal14BlueW600,),
                                Text("Name of center",style: AppFonts.tajawal14BlackW400,),
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
