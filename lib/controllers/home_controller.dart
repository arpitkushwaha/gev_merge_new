import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/db_manager.dart';
import 'package:gev_app/views/view_walk_in_screen.dart';
import 'package:gev_app/views/walkin.dart';

class HomeController {
  //Navigate to ViewWalkInScreen or WalkInScreen
  void navigateToCorrectScreen(BuildContext context) async {
    List<Map> list = await getDataList();
    if (list.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Walkin()));
    } else {
      if (Common.convertStringToTimeOfDay(list[0]['Slot_time_start']).hour ==
          10) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewWalkInScreen('assets/images/Walk_in_ticket.png')),
        );
      } else if (Common.convertStringToTimeOfDay(list[0]['Slot_time_start'])
              .hour ==
          13) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewWalkInScreen('assets/images/walk_in_ticket_green.png')),
        );
      }
    }
    print('HOME CONTROLLER : $list');
  }

  //Get all the records of mobile_user_details Table from DB
  Future<List<Map>> getDataList() async {
    DbManager dbManager = DbManager();
    List<Map> list = await dbManager
        .getRecords(Constant.queryToGetAllRecordsOfMobileUserDetailsTable);
    return list;
  }

  //All the necessary scheduled tasks of DB are done by calling this single function on HomeScreen
  refreshDB() {
    print('Inside refreshDB');
    deleteRecordOfWalkInUser();
  }

  //Delete record of WalkIn user after 4:05 PM from DB
  deleteRecordOfWalkInUser() {
    DbManager dbManager = DbManager();
    print('Inside deleteRecordOfWalkInUser');
    //Delete record if the time is between 4:05 PM to 12:00 AM
    if (!(DateTime.now().isAfter(Common.convertTimeOfDayToDateTime(
            TimeOfDay(hour: 16, minute: 5))) &&
        DateTime.now().isBefore(Common.convertTimeOfDayToDateTime(
            TimeOfDay(hour: 1, minute: 0))))) {
      print(
          'Inside: if (Delete record if the time is between 4:05 PM to 12:00 AM) ');
      dbManager.delete(Constant.mobileUserDetails, 'id = ?', [1]);
    } else {
      print(
          'Inside: else (Delete record if the time is between 4:05 PM to 12:00 AM) ');
    }
  }
}
