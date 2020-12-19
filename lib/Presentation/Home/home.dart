import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Previous_Record/abc.dart';

import 'package:parkinsin_disease_detection/Presentation/Previous_Record/previous_record.dart';
import 'package:parkinsin_disease_detection/Presentation/Test/testhome.dart';

import 'menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  var _pages = [homepage(), Previous_record()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14171A),
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a1a),
        iconTheme: new IconThemeData(color: Color(0xFF4f5f8fa)),
        /*leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
           onPressed: () {
            
           },
           ),*/

        title: Center(
          child: Text(
            "PDD",
            style: TextStyle(
                color: Color(0xFF4f5f8fa), fontSize: 25.0, fontFamily: "Satisfy"
                //fontWeight: FontWeight.bold,
                ),
          ),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1a1a1a),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Take Test'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            title: Text('Previous Record'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF919191),
        unselectedItemColor: Color(0xFFededed),
        onTap: _onItemTapped,
      ),
    );
  }
}
