import 'package:accounting/home_screen.dart';
import 'package:accounting/info_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var Screens = [const HomeScreen(), const InfoScreen()];

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: const Color(0xfff5f5f5),
          selectedIndex: _currentIndex,
          showElevation: false,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text(
                  'خانه',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                activeColor: Colors.black45,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: const Icon(Icons.info_outline),
                title: const Text('اطلاعات'),
                activeColor: Colors.black45,
                textAlign: TextAlign.center),
          ],
        ),
        body: Screens[_currentIndex],
      ),
    );
  }
}
