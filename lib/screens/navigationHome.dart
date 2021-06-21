import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tutors/data/utils/NotificationManager.dart';
import 'package:tutors/data/utils/Utils.dart';
import 'package:tutors/screens/profile.dart';

import '../constants.dart';
import 'home.dart';

class NavScreen {
  final String title;
  final Widget screens;
  final Widget icon;

  NavScreen({required this.title, required this.screens, required this.icon});
}

class NavigationHome extends StatefulWidget {
  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  final List<NavScreen> _screens = [
    /// home
    NavScreen(
      title: 'Home',
      screens: Home(),
      icon: Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
    ),

    /// work
    NavScreen(
      title: 'Work',
      screens: Work(),
      icon: Icon(
        Icons.work,
        size: 30,
        color: Colors.white,
      ),
    ),

    /// history
    NavScreen(
      title: 'History',
      screens: History(),
      icon: Icon(
        Icons.history,
        size: 30,
        color: Colors.white,
      ),
    ),

    /// chat
    NavScreen(
      title: 'Chat',
      screens: Center(
        child: ElevatedButton(
          onPressed: () {
            launchWhatsapp();
          },
          child: Text('Open Whatsapp'),
        ),
      ),
      icon: Icon(
        Icons.chat,
        size: 30,
        color: Colors.white,
      ),
    ),

    /// profile
    NavScreen(
      title: 'Profile',
      screens: Profile(),
      icon: Icon(
        Icons.person,
        size: 30,
        color: Colors.white,
      ),
    ),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    NotificationManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        accentColor: kBlueColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kBlueColor, //change your color here
          ),
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Colors.transparent,
          title: Text(
            '${_screens[_selectedIndex].title}',
            style: TextStyle(color: kBlueColor),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: kBlueColor,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Colors.transparent,
          height: 50,
          items: [for (NavScreen screen in _screens) screen.icon],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _screens[_selectedIndex].screens,
      ),
    );
  }
}
