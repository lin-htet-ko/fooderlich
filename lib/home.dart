import 'package:flutter/material.dart';
import 'package:fooderlich/card1.dart';

import 'card2.dart';
import 'card3.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var pages = [Card1(), Card2(), Card3()];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fooderlich",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTap,
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Card1"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Card2"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Card3"),
        ],
      ),
    );
  }
}
