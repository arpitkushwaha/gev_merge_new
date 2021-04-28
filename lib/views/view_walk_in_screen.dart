import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:gev_app/controllers/view_walk_in_controller.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ViewWalkInScreen extends StatefulWidget {
  final String imageUrl;
  ViewWalkInScreen(this.imageUrl);
  @override
  _ViewWalkInScreenState createState() => _ViewWalkInScreenState(imageUrl);
}

class _ViewWalkInScreenState extends State<ViewWalkInScreen> {
  int noOfVisitors = 6;

  var timeRemaining = '00:15';
  Future<List<Map>> list;
  String imageUrl;
  ViewWalkInController viewWalkInController = ViewWalkInController();
  _ViewWalkInScreenState(this.imageUrl);

  @override
  void initState() {
    super.initState();
    setState(() {
      list = viewWalkInController.getDataList();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Inside Widget build of Walkin Screen');
    print("initState : $list");
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: Common.appBar('View Walk-In'),
        bottomNavigationBar: BottomNavbar(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingHomeButton(),
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: Common.background(),
            child: Column(
              children: [
                new SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Image.asset(
                    "assets/images/logo.png",
                    scale: 0.8,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight / 15,
                ),
                Center(
                  child: list == null
                      ? Text('Loading...')
                      : FutureBuilder(
                          future: list,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Number of visitors - ${snapshot.data[0]['additional_member']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('');
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight / 55,
                ),
                Center(
                  child: Image.asset(
                    imageUrl,
                    height: SizeConfig.screenHeight / 4,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight / 245,
                ),
                Center(
                  child: list == null
                      ? Text('Loading...')
                      : FutureBuilder(
                          future: list,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountdownTimer(
                                    endTime: Common.convertTimeOfDayToDateTime(
                                            Common.convertStringToTimeOfDay(
                                                snapshot.data[0]
                                                    ['Slot_time_end']))
                                        .millisecondsSinceEpoch,
                                    widgetBuilder:
                                        (_, CurrentRemainingTime time) {
                                      if (time == null) {
                                        return Text(
                                          'Please return to the main gate',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                        );
                                      }
                                      return Text(
                                        'Time Remaining: \n Hour:${time.hours}, Min:${time.min}, Sec:${time.sec}0',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('');
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
