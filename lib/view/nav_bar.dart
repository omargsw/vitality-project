import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/main.dart';
import 'package:vitality/view/adminViews/admin_categories.dart';
import 'package:vitality/view/adminViews/admin_news.dart';
import 'package:vitality/view/adminViews/admin_reservations.dart';
import 'package:vitality/view/adminViews/admin_users.dart';
import 'package:vitality/view/centerViews/canter_profile_screen.dart';
import 'package:vitality/view/centerViews/center_categories.dart';
import 'package:vitality/view/centerViews/reservations_department.dart';
import 'package:vitality/view/centers_page.dart';
import 'package:vitality/view/home_page.dart';
import 'package:vitality/view/profile_screen.dart';
import 'package:vitality/view/reservations_list.dart';
import 'package:vitality/view/splash_screen.dart';

class NavBar extends StatefulWidget {
  final int? typeId;
  const NavBar({Key? key, required this.typeId}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
// int? userId = sharedPreferences!.getInt('userID');
  String? accountImage = sharedPreferences!.getString('image');
  int _currentIndex = 0;
  int _currentIndexCenter = 0;
  int _currentIndexAdmin = 0;

  @override
  void initState() {
    super.initState();
    print(accountImage);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      const HomePage(),
      const CentersPage(),
      const ReservationsList(),
      const ProfileScreen(),
    ];
    final List<Widget> _pagesCenter = <Widget>[
      const ReservationsDepartment(),
      const CenterCategories(),
      const CenterProfileScreen(),
    ];
    final List<Widget> _pagesAdmin = <Widget>[
      const AdminCategories(),
      const AdminUsers(),
      const AdminNews(),
      const AdminReservations(),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    void _onItemTappedCenter(int index) {
      setState(() {
        _currentIndexCenter = index;
      });
    }

    void _onItemTappedAdmin(int index) {
      setState(() {
        _currentIndexAdmin = index;
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: widget.typeId == 3
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: Image.network(
                      widget.typeId == 1
                          ? WebConfig.baseUrl +
                              WebConfig.customerImage +
                              accountImage.toString()
                          : WebConfig.baseUrl +
                              WebConfig.centerImages +
                              accountImage.toString(),
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          title: Text(
            "Vitality",
            style: AppFonts.tajawal25GreenW600,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(SplashScreen());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: widget.typeId == 1
            ? BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: _currentIndex,
                backgroundColor: colorScheme.surface,
                selectedItemColor: AppColors.secondaryColor,
                unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
                selectedLabelStyle: textTheme.caption,
                unselectedLabelStyle: textTheme.caption,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Centers',
                    icon: Icon(Icons.store),
                  ),
                  BottomNavigationBarItem(
                    label: 'Reservations',
                    icon: Icon(Icons.list_alt),
                  ),
                  BottomNavigationBarItem(
                    label: 'Profile',
                    icon: Icon(Icons.person),
                  ),
                ],
              )
            : widget.typeId == 2
                ? BottomNavigationBar(
                    type: BottomNavigationBarType.shifting,
                    currentIndex: _currentIndexCenter,
                    backgroundColor: colorScheme.surface,
                    selectedItemColor: AppColors.secondaryColor,
                    unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
                    selectedLabelStyle: textTheme.caption,
                    unselectedLabelStyle: textTheme.caption,
                    onTap: _onItemTappedCenter,
                    items: const [
                      BottomNavigationBarItem(
                        label: 'Reservations',
                        icon: Icon(Icons.list_alt),
                      ),
                      BottomNavigationBarItem(
                        label: 'Food Plan',
                        icon: Icon(Icons.fastfood),
                      ),
                      BottomNavigationBarItem(
                        label: 'Profile',
                        icon: Icon(Icons.person),
                      ),
                    ],
                  )
                : BottomNavigationBar(
                    type: BottomNavigationBarType.shifting,
                    currentIndex: _currentIndexAdmin,
                    backgroundColor: colorScheme.surface,
                    selectedItemColor: AppColors.secondaryColor,
                    unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
                    selectedLabelStyle: textTheme.caption,
                    unselectedLabelStyle: textTheme.caption,
                    onTap: _onItemTappedAdmin,
                    items: const [
                      BottomNavigationBarItem(
                        label: 'Categories',
                        icon: Icon(Icons.category),
                      ),
                      BottomNavigationBarItem(
                        label: 'Users',
                        icon: Icon(Icons.supervisor_account),
                      ),
                      BottomNavigationBarItem(
                        label: 'News',
                        icon: Icon(Icons.newspaper),
                      ),
                      BottomNavigationBarItem(
                        label: 'Reservations',
                        icon: Icon(Icons.list_alt),
                      ),
                    ],
                  ),
        // drawer: const NavDrawer(),
        body: Center(
            child: widget.typeId == 1
                ? _pages.elementAt(_currentIndex)
                : widget.typeId == 2
                    ? _pagesCenter.elementAt(_currentIndexCenter)
                    : _pagesAdmin.elementAt(_currentIndexAdmin)));
  }
}
