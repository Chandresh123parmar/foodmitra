import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CartScreen.dart';
import 'HomeScreen.dart';

class Bottombarnavigatorscreen extends StatefulWidget {
  const Bottombarnavigatorscreen({super.key});

  @override
  State<Bottombarnavigatorscreen> createState() => _BottombarnavigatorscreenState();
}

class _BottombarnavigatorscreenState extends State<Bottombarnavigatorscreen> {

  int _currentIndex = 0;

  static const List<Widget> items = [
    HomeScreen(),
    CartScreen(),
  ];
  void ontapmethod(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedFontSize: 20,
        onTap:ontapmethod,
        currentIndex: _currentIndex,
          items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined),label: 'Cart')
      ]),
      drawer: Drawer(
        child: ListView(
          children: [

          ],
        ),
      ),
      body: items.elementAt(_currentIndex),
    );
  }
}
