import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/main_app_bar.dart';
import 'meal_details_card.dart';

class MealsDetails extends StatefulWidget {
  final String? title;
  final String? imagePath;
  const MealsDetails({Key? key,required this.title,required this.imagePath}) : super(key: key);

  @override
  State<MealsDetails> createState() => _MealsDetailsState();
}

class _MealsDetailsState extends State<MealsDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: mainAppBar(title: widget.title, iconButton: null),
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 2.85,
            ),
            itemCount: 10,
            itemBuilder: (_, index) {
              return  GestureDetector(
                onTap: () {
                 Get.to(const MealDetailsCard(imagePath: 'assets/images/dinner.jpg',title: "text",));
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
                              widget.imagePath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.white54,
                                child: Text("Name of Product",style: AppFonts.tajawal14BlueW600,textAlign: TextAlign.center,),
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

      ),
    );
  }
}
