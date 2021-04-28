import 'package:flutter/material.dart';
import 'package:gev_app/controllers/usertype_controller.dart';
import 'package:gev_app/views/accommodation_map_predisplay.dart';
import 'package:gev_app/views/accommodation_pre_display_walkin.dart';
import 'package:gev_app/views/feedback_screen.dart';
import 'package:gev_app/views/location_map_predisplay.dart';
import 'package:gev_app/views/support_a_cause_screen.dart';

class HomeSection3 extends StatefulWidget {
  @override
  _HomeSection3State createState() => _HomeSection3State();
}

class _HomeSection3State extends State<HomeSection3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.hotel),
                  color: Colors.orangeAccent[400],
                  iconSize: 30.0,
                  onPressed: () {
                    var usertype = UserType().getdata();
                    usertype = "check-In";
                    if (usertype == "walk-In") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AccommodationPreDisplayWalkIn()),
                      );
                    } else if (usertype == "check-In") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccommodationMapPredisplay()));
                    } else {
                      print("register first");
                    }
                  },
                ),
                Text('Accommodation'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.map),
                  color: Colors.orangeAccent[400],
                  iconSize: 30.0,
                  onPressed: () {
                    var usertype = UserType().getdata();
                    usertype = "check-In";
                    if (usertype == "walk-In") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationMapPreDisplay()));
                    } else if (usertype == "check-In") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationMapPreDisplay()));
                    } else {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => GmapSkipUser()));
                    }
                  },
                ),
                Text('Map'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.volunteer_activism),
                  color: Colors.orangeAccent[400],
                  iconSize: 30.0,
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(context, '/supportACause',
                    //     ModalRoute.withName('/supportACause'));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupportACause()));
                  },
                ),
                Text('Support a '),
                Text('Cause'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.feedback),
                  color: Colors.orangeAccent[400],
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => FeedbackScreen()));
                  },
                ),
                Text('Feedback'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
