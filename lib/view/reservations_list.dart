import 'package:flutter/material.dart';
import 'package:vitality/components/fonts.dart';

class ReservationsList extends StatefulWidget {
  const ReservationsList({Key? key}) : super(key: key);

  @override
  State<ReservationsList> createState() => _ReservationsListState();
}

class _ReservationsListState extends State<ReservationsList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
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
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.asset('assets/images/logo.jpeg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Center name",style: AppFonts.tajawal14GreenW600,),
                    trailing: Text("Status",style: AppFonts.tajawal14BlackW400,),
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
