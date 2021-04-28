import 'package:flutter/material.dart';
import 'package:gev_app/controllers/home_controller.dart';
import 'package:gev_app/utilities/preferences.dart';
import 'package:gev_app/views/check_in_screen.dart';
import 'package:gev_app/views/view_check_in_screen.dart';
import 'package:gev_app/views/walkin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSection1 extends StatefulWidget {
  @override
  _HomeSection1State createState() => _HomeSection1State();
}

class _HomeSection1State extends State<HomeSection1> {
  HomeController homeController = HomeController();
  Preferences preferences = Preferences();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  // height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                    child: new ElevatedButton(
                      style: ButtonStyle(
                        // minimumSize: MaterialStateProperty.all(),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange[900]),
                        // minimumSize: MaterialStateProperty.all(),
                      ),
                      onPressed: () async {
                        // Preferences().clearUserType();
                        // UserType().setcheckInPref();
                        // UserType().getdata();
                        //           if (usertype == "walk-In") {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => GmapWalkIn()),
                        //   );
                        // } else if (usertype == "check-In") {
                        //   Navigator.pushReplacement(context,
                        //       MaterialPageRoute(builder: (context) => GmapChecKIn()));
                        // } else {
                        //   Navigator.pushReplacement(context,
                        //       MaterialPageRoute(builder: (context) => GmapSkipUser()));
                        // }
                        if (preferences.getPreferences('check_in_code') ==
                            null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckInScreen()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCheckInScreen()),
                          );
                        }
                      },
                      child: new Text(
                        'Check-In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          // height: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                  ),
                  child: Text(
                    'For our inhouse guests',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  // height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                    child: new ElevatedButton(
                      style: ButtonStyle(
                        // minimumSize: MaterialStateProperty.all(),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange[900]),
                        // minimumSize: MaterialStateProperty.all(),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Walkin()),
                        );
                        // //Show Snackbar and restrict the navigation to next screen if the time is between 4:05 PM to 12:00 AM
                        // if (!(DateTime.now().isBefore(
                        //         Common.convertTimeOfDayToDateTime(
                        //             TimeOfDay(hour: 16, minute: 5))) &&
                        //     DateTime.now().isAfter(
                        //         Common.convertTimeOfDayToDateTime(
                        //             TimeOfDay(hour: 0, minute: 0))))) {
                        //   final snackBar = SnackBar(
                        //     content:
                        //         Text('No time slots are available for today'),
                        //   );

                        //   // Find the ScaffoldMessenger in the widget tree
                        //   // and use it to show a SnackBar.
                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //   return;
                        // }

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        if (prefs.getString('isSkippedUser') == "true") {
                          print('skipped User');
                          _showAlertDialog('Login', 'Please login first');
                        } else {
                          homeController.navigateToCorrectScreen(context);
                        }
                      },
                      child: new Text(
                        'Walk-In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          // height: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                  ),
                  child: Text(
                    'For our daily visitors',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(titleAlert, contentAlert) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titleAlert),
      content: Text(contentAlert),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
