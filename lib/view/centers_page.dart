import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/view/center_details.dart';

class CentersPage extends StatefulWidget {
  const CentersPage({Key? key}) : super(key: key);

  @override
  State<CentersPage> createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Text("Slimming centers",style: AppFonts.tajawal20BlueW600,),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 2.85,
                ),
                itemCount: 10,
                itemBuilder: (_, index) {
                  return  GestureDetector(
                      onTap: () {
                        Get.to(const CenterDetailsPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                // offset: const Offset(3, 3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    "assets/images/logo.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      color: Colors.white,
                                      child: Text("Name of center",style: AppFonts.tajawal14BlueW600,textAlign: TextAlign.center,),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
