import 'package:flutter/material.dart';
import 'package:vitality/components/color.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              // UserInfoApi userApi = widget.user![index];
              // if(widget.user!.isEmpty || widget.user == null){
              //   return Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       CircularProgressIndicator(),
              //     ],
              //   );
              // }else{
                return Column(
                  children: [
                    InkWell(
                      onTap: (){

                      },
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        accountName: Text("name"),
                        accountEmail: Text("email"),
                        currentAccountPicture: ClipOval(
                          child: Image.asset('assets/images/logo.jpeg',
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // ListTile(
                    //     title: const Text('My Posts',style: TextStyle(),),
                    //     leading: Icon(Icons.assignment_outlined,color: ColorForDesign().blue,),
                    //     trailing: const Icon(Icons.arrow_right),
                    //     onTap: (){
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (BuildContext context) => MyPosts())
                    //       );
                    //     }
                    // ),

                    // ListTile(title: const Text('Logout',style: TextStyle(),),
                    //     leading: Icon(Icons.logout,color: ColorForDesign().blue,),
                    //     trailing: const Icon(Icons.arrow_right),
                    //     onTap: () async {
                    //       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    //       sharedPreferences.clear();
                    //       // await FirebaseAuth.instance.signOut();
                    //       Navigator.of(context).pushAndRemoveUntil(
                    //           MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
                    //               (Route<dynamic> route) => false);
                    //     }),
                  ],
                );
            },

          ),
        )
      ),
    );
  }
}




//NavDrawer