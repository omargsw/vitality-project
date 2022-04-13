import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';

class ReservationsDepartment extends StatefulWidget {
  const ReservationsDepartment({Key? key}) : super(key: key);

  @override
  State<ReservationsDepartment> createState() => _ReservationsDepartmentState();
}

class _ReservationsDepartmentState extends State<ReservationsDepartment> {
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
                    // Container(
                    //   width: width * 0.95,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.4),
                    //         offset: const Offset(4, 4),
                    //         blurRadius: 16,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: ListTile(
                    //       leading: ClipOval(
                    //         child: Image.asset('assets/images/logo.jpeg',
                    //           width: 50,
                    //           height: 50,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //       title: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("name",style: AppFonts.tajawal16GreenW600,),
                    //           Text("Phone",style: AppFonts.tajawal14BlueW600,),
                    //         ],
                    //       ),
                    //       trailing: Container(
                    //         height: 40,
                    //         width: 40,
                    //         padding: const EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50),
                    //           color: Colors.green,
                    //         ),
                    //         child: const Center(
                    //             child: Icon(Icons.done,color: Colors.white,)
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: (){
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialogWidget(title: "Are you sure to accept the reservation?",
                                            onTapYes: (){});
                                      });
                                },
                                child: const IconButtonWidget(color: Colors.green, icons: Icons.done)),
                            const SizedBox(width: 8,),
                            InkWell(
                              onTap: (){
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialogWidget(title: "Are you sure to reject the reservation?",
                                          onTapYes: (){});
                                    });
                              },
                              child: const IconButtonWidget(color: Colors.red, icons: Icons.cancel_outlined),
                            ),
                            const SizedBox(width: 10,),
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
