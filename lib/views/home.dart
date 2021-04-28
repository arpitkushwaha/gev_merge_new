import 'package:flutter/material.dart';
import 'package:gev_app/controllers/home_controller.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/home_section1.dart';
import 'package:gev_app/utilities/home_section2.dart';
import 'package:gev_app/utilities/home_section3.dart';
import 'package:gev_app/utilities/home_section4.dart';
import 'package:gev_app/utilities/home_section7.dart';
import 'package:gev_app/controllers/login_controller.dart';

// Home screen .

class MyHomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyHomePage> {
  LogInController logInController = LogInController();
  HomeController homeController = HomeController();
  @override
  void initState() {
    super.initState();
    homeController.refreshDB();
    print('Inside HomeScreen init');
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            height: queryData.size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: ListView(
              children: [
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: TextButton(
                //     child: Text('Logout'),
                //     onPressed: () {
                //       logInController.logout();
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (context) => Login()));
                //     },
                //   ),
                // ),
                HomeSection1(),
                HomeSection2(),
                HomeSection3(),
                HomeSection4(),
                HomeSection7(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingHomeButton(),
        ),
      ),
    );
  }
}
