import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gev_app/controllers/schedule_controller.dart';
import 'package:gev_app/models/schedule_list_model.dart';
import 'package:gev_app/utilities/commons.dart';

// Screen to get the schedule for events in GEV.
class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleController scheduleController = ScheduleController();
  List<ScheduleListModel> templeList;
  @override
  void initState() {
    super.initState();
    setState(() {
      templeList = scheduleController.getTempleList();
      print(templeList[0].imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar('Today\'s Schedule'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: ListView.builder(
        itemCount: scheduleController.getTempleList().length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 40, right: 40),
            child: InkWell(
              onTap: () {
                showAlertBox(context, index);
              },
              child: Container(
                height: 200,
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.99), BlendMode.dstATop),
                    image: AssetImage(templeList[index].imageUrl),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${templeList[index].imageText}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AlertDialog showAlertBox(BuildContext context, int index) {
    var alertBox = AlertDialog(
      title: Text(
        'Name : ${templeList[index].name}',
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Time: ${templeList[index].time}'),
            SizedBox(
              height: 2,
            ),
            Text('Description: ${templeList[index].description}'),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (buildContext) {
          return alertBox;
        });
    return null;
  }
}
