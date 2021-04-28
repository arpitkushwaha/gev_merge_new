import 'package:flutter/material.dart';
import 'package:gev_app/models/event_list_model.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/controllers/event_controller.dart';

import '../utilities/constants.dart';

// Event Screen to get the details of each and every event in  GEV.
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventController eventController = EventController();
  Future<List<EventListModel>> eventList;
  int selectedYear;
  String selectedMonth;
  String selectedFilter;

  @override
  void initState() {
    super.initState();
    eventList = eventController.fetchEventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar('Events'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5, top: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: DropdownButton<int>(
                          value: selectedYear,
                          hint: Text(
                            "Year",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              height: 1.3),
                          icon: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 2,
                          ),
                          items: Common.getYearList().map((int value) {
                            return new DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                value.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          hint: Text(
                            "Month",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              height: 1.3),
                          icon: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 2,
                          ),
                          items: Common.getMonthList().map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value;
                            });
                          },
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          hint: Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              height: 1.3),
                          icon: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 2,
                          ),
                          items: Common.getMoneyFilterList().map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedFilter= value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: InkWell(
                          onTap:(){
                              setState(() {
                                eventList = eventController.updateEventList(selectedYear, selectedMonth, selectedFilter);
                                print('EventScreen: $eventList');
                              });
                          },
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: FutureBuilder<List<EventListModel>>(
                  future: eventList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? _createEventCards(snapshot.data)
                        : Center(child: CircularProgressIndicator());
                    // return the ListView widget :
                    // Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog showAlertBox(List<EventListModel> eventList, int index) {
    var alertBox = AlertDialog(
      backgroundColor: Colors.deepOrange[200],
      elevation: 3.0,
      title: Text(
        '${eventList[index].eventName}',
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Date: ${eventList[index].eventDate}'),
            SizedBox(
              height: 2,
            ),
            Text('Description: ${eventList[index].description}'),
            SizedBox(
              height: 2,
            ),
            Text('From: ${eventList[index].startTime}'),
            SizedBox(
              height: 2,
            ),
            Text('To: ${eventList[index].endTime}'),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (buildContext) {
          return alertBox;
        });
  }

  Widget _createEventCards(List<EventListModel> eventList) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 20, right: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 10, left: 10),
                      child: InkWell(
                        onTap: () {
                          showAlertBox(eventList, index);
                        },
                        child: Container(
                          height: 55,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(Constant.starColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 15, bottom: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${eventList[index].eventName}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, top: 15, bottom: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${eventList[index].eventDate}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
