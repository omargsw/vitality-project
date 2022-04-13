import 'package:flutter/material.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Customers account",style: AppFonts.tajawal20BlueW600,),
            ),
            SizedBox(
              width: width,
              height: 250,
              child: Expanded(
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Container(
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
                                    Text("Omar Wathaifi",style: AppFonts.tajawal16GreenW600,),
                                    Text("omar@gmail.com",style: AppFonts.tajawal14GreenW600,),
                                    Text("0787878789",style: AppFonts.tajawal14BlueW600,),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                    onTap: (){
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialogWidget(title: "Are you sure to make Omar Wathaifi as a center account?",
                                                onTapYes: (){});
                                          });
                                    },
                                    child: const IconButtonWidget(color: Colors.green, icons: Icons.playlist_add_sharp)),
                                const SizedBox(width: 5,),
                                InkWell(
                                  onTap: (){
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialogWidget(title: "Are you sure to delete this account?",
                                              onTapYes: (){});
                                        });
                                  },
                                  child: const IconButtonWidget(color: Colors.red, icons: Icons.delete),
                                ),
                              ],
                            ),
                          ),
                    )
                    );
                },),
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(color: Colors.black45,endIndent: 20,indent: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Centers account",style: AppFonts.tajawal20BlueW600,),
            ),
            SizedBox(
              width: width,
              height: 250,
              child: Expanded(
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Container(
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
                            child: ListTile(
                              leading: ClipOval(
                                child: Image.asset('assets/images/logo.jpeg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Omar Wathaifi",style: AppFonts.tajawal16GreenW600,),
                                  Text("omar@gmail.com",style: AppFonts.tajawal14GreenW600,),
                                  Text("0787878789",style: AppFonts.tajawal14BlueW600,),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: (){
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialogWidget(title: "Are you sure to delete this account?",
                                            onTapYes: (){});
                                      });
                                },
                                child: const IconButtonWidget(color: Colors.red, icons: Icons.delete),
                              ),
                            )
                        )
                    );
                  },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
