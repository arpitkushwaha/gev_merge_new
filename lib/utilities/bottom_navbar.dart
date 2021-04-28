import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  int _currentIndex = 0;
  // final List<Widget> _children = [];
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (context) => EventScreen()));
    }
    if (index == 1) {
      // Navigator.pushReplacement(context,
      // MaterialPageRoute(builder: (context) => Gmap()));
    }
    if (index == 2) {
      // Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
    }
    if (index == 3) {
      // Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
  }

  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.amber[300],
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.brown,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(
                  color: Colors
                      .black))), // sets the inactive color of the `BottomNavigationBar`
      child: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // currentIndex: 2,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/events.png",
              scale: 1.5,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/map.png",
              scale: 1.5,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(null
                // Icons.home,
                // size: 40,
                ),
            label: 'Home',
            // label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/schedule.png",
              scale: 1.5,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/profile.png",
              scale: 1.5,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
        // backgroundColor: Colors.amber[400],
        unselectedItemColor: Colors.brown,
        // showUnselectedLabels: true,
        fixedColor: Colors.brown,
        // selectedItemColor: Colors.brown,
        // unselectedLabelStyle: TextStyle(color: Colors.black),
        // onTap: null,
      ),
    );
  }
}
