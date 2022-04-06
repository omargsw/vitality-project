import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vitality/components/app_bar_login.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/view/centers_page.dart';
import 'package:vitality/view/home_page.dart';
import 'package:vitality/view/profile_screen.dart';
import 'package:vitality/view/reservations_list.dart';
import 'package:vitality/widgets/drawer.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      const HomePage(),
      const CentersPage(),
      const ReservationsList(),
      ProfileScreen(),
      // AddPost(),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipOval(
            child: Image.asset('assets/images/lunch.jpg',
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
          IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.black,))
        ],
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      // drawer: const NavDrawer(),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      )
    );
  }
}
