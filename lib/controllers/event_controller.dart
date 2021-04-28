import 'package:flutter/material.dart';
import 'package:gev_app/models/event_list_model.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/db_manager.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class EventController {
  DbManager dbManager;

  // List to get the feedbacks for the item builder (home screen).
  Future<List<EventListModel>> fetchEventList() async {
    List<EventListModel> eventList;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makeGetRequest('fetch-events');
    print('response' + response.toString());
    eventList = List<EventListModel>.from(
        response['events'].map((json) => EventListModel.fromJson(json)));
    // print('feedbackList list controller: ' + eventList[1].name.toString());
    return eventList;
  }

// Update Event List based on Filters
  Future<List<EventListModel>> updateEventList(int year, String month, String filter) async
  {

    print('updateEventList:    year: $year, month: $month, filter: $filter');
    List <EventListModel> list = await fetchEventList();

    if(year != null)
    list.removeWhere((item) =>
    Common
        .convertStringToDateTime(item.eventDate)
        .year != year);

    if(month != null)
    list.removeWhere((item) =>
    Common
        .convertStringToDateTime(item.eventDate)
        .month != convertMonthToInt(month));

    if(filter != null)
    list.removeWhere((item) =>
     item.eventCategory != filter);


    print('updateEventList: $list');

    return list;

  }


  //Convert Month String to Int
  int convertMonthToInt(String m)
  {
    int month=0;
    switch(m)
    {
      case 'January':
        month = 1;
        break;
      case 'February':
        month = 2;
        break;
      case 'March':
        month = 3;
        break;
      case 'April':
        month = 4;
        break;
      case 'May':
        month = 5;
        break;
      case 'June':
        month = 6;
        break;
      case 'July':
        month = 7;
        break;
      case 'August':
        month = 8;
        break;
      case 'September':
        month = 9;
        break;
      case 'October':
        month = 10;
        break;
      case 'November':
        month = 11;
        break;
      case 'December':
        month = 12;
        break;
    }
    
    return month;
  }


  // List to get events for the item builder.
  List<EventListModel> getEventList(int year, String month) {
    // HashMap map = HashMap<String, String>();
    //dbManager.insert("", map);

    // List<EventListModel> eventList = [
    //   EventListModel(
    //       eventName: 'Govardhan Puja',
    //       date: '11/02/2021',
    //       description: 'Pooja'),
    //   EventListModel(
    //       eventName: 'Yamuna Arti', date: '11/02/2021', description: 'Pooja'),
    //   EventListModel(
    //       eventName: 'Evening Arti', date: '11/02/2021', description: 'Pooja'),
    // ];
    // return eventList;
  }

  // Dummy code for generating notification.
  void setNotifications() {
    // LocalNotifyManager.localNotifyManager = LocalNotifyManager.init();
    // LocalNotifyManager.localNotifyManager
    //     .setOnNotificationReceive(onNotificationReceive);
    // LocalNotifyManager.localNotifyManager
    //     .setOnNotificationClick(onNotificationClick);

    // await LocalNotifyManager.localNotifyManager.showNotification();
    //await LocalNotifyManager.localNotifyManager.scheduleNotification();
    //await LocalNotifyManager.localNotifyManager.showDailyAtTimeNotification();
    //await LocalNotifyManager.localNotifyManager.showWeeklyAtDayTimeNotification();

    // onNotificationReceive(RecieveNotification notification) {
    //   print('Notification Recieved: ${notification.id}');
    // }
    //
    // onNotificationClick(String payload) {
    //   print('Payload $payload');
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return ScreenSecond(payload: payload);
    //   }));
    // }
  }
}
