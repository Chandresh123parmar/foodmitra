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

  final List<Widget> items = [
    HomeScreen(),
    CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
          onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          },
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
      body: items[_currentIndex]
    );
  }
}
