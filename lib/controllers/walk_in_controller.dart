import 'package:flutter/material.dart';
import 'package:gev_app/models/mobile_user_details.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/db_manager.dart';
import 'package:gev_app/views/view_walk_in_screen.dart';

class WalkInController {
  DbManager dbManager;
  BuildContext context;
  // time slot list for dropdown.
  List<String> timeSlotList = [
    '10:00 A.M. To 1:00 P.M.',
    '1:00 P.M. To 4:00 P.M.'
  ];

  WalkInController({this.context});

  List<String> getTimeSlots() {
    return timeSlotList;
  }

  //save time slot and additional member in db.
  saveDataInDB(MobileUserDetails mobileUserDetails) async {
    dbManager = DbManager();

    int id = await dbManager.getLastID(Constant.mobileUserDetails);

    mobileUserDetails = checkTimeSlot(mobileUserDetails);
    // dbManager.createTableIfNotExists(Constant.mobile_user_details,
    //     Constant.queryToCreateMobileUserDetailsTable);
    print('Inside saveDataInDB');
    if (id == 1) {
      print('Inside saveDataInDB lastId==1');
      dbManager.update(
          Constant.mobileUserDetails, mobileUserDetails.toJson(), 'id = 1');
      dbManager.getLastID(Constant.mobileUserDetails);
    } else {
      print('Inside saveDataInDB lastId!=1');
      dbManager.insert(Constant.mobileUserDetails, mobileUserDetails.toJson());
      dbManager.getLastID(Constant.mobileUserDetails);
    }

    List<Map> list = await dbManager
        .getRecords(Constant.queryToGetAllRecordsOfMobileUserDetailsTable);
    navigateToCorrectScreen(mobileUserDetails);
  }

  // function to check time slot.
  MobileUserDetails checkTimeSlot(MobileUserDetails mobileUserDetails) {
    if (mobileUserDetails.slotTimeStart == '10:00 A.M. To 1:00 P.M.') {
      mobileUserDetails.slotTimeStart =
          Common.convertTimeOfDayToString(TimeOfDay(hour: 10, minute: 0));
      mobileUserDetails.slotTimeEnd =
          Common.convertTimeOfDayToString(TimeOfDay(hour: 13, minute: 0));
      // return mobileUserDetails;
    } else if (mobileUserDetails.slotTimeStart == '1:00 P.M. To 4:00 P.M.') {
      mobileUserDetails.slotTimeStart =
          Common.convertTimeOfDayToString(TimeOfDay(hour: 13, minute: 0));
      mobileUserDetails.slotTimeEnd =
          Common.convertTimeOfDayToString(TimeOfDay(hour: 16, minute: 0));
      // return mobileUserDetails;
    }
    return mobileUserDetails;
  }

  //This function navigates to the Green Ticket or Brown Ticket according to time slot
  navigateToCorrectScreen(MobileUserDetails mobileUserDetails) {
    if (Common.convertStringToTimeOfDay(mobileUserDetails.slotTimeStart).hour ==
        10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewWalkInScreen('assets/images/Walk_in_ticket.png')),
      );
    } else if (Common.convertStringToTimeOfDay(mobileUserDetails.slotTimeStart)
            .hour ==
        13) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewWalkInScreen('assets/images/walk_in_ticket_green.png')),
      );
    }
  }
}
