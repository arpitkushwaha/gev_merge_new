import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gev_app/controllers/walk_in_controller.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/models/mobile_user_details.dart';

class Walkin extends StatefulWidget {
  @override
  _WalkinState createState() => _WalkinState();
}

class _WalkinState extends State<Walkin> {
  TextEditingController additionalMemberCon = TextEditingController();
  WalkInController walkInController;
  List<String> timeSlots;
  String selectedTimeSlot;

  //  _formKey and _autoValidate
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  String dropdownValue = '10:00 am to 1:00 pm';
  var firstSlot = 10;
  var seconSlot = 1;
  var endtime = 4;
  var walkinCount;

  @override
  Widget build(BuildContext context) {
    walkInController = WalkInController(context: context);
    timeSlots = walkInController.getTimeSlots();
    SizeConfig().init(context);

    return Scaffold(
      appBar: Common.appBar('Walk In'),
      body: SingleChildScrollView(
        child: Container(
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                  //isEmpty: selectedTimeSlot == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Slots'),
                      focusColor: Colors.white,
                      value: selectedTimeSlot,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          selectedTimeSlot = newValue;
                          //state.didChange(newValue);
                        });
                      },
                      items: timeSlots.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: additionalMemberCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'No. of Visitors',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  )),
              new SizedBox(
                height: 25.0,
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(25.0),
                  ),
                  child: new TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange[900]),
                      //minimumSize: MaterialStateProperty.all(widget:4),
                    ),
                    onPressed: () {
                      //Show Snackbar and restrict the navigation to next screen if the time is between 4:05 PM to 12:00 AM
                      if (!(DateTime.now().isBefore(
                              Common.convertTimeOfDayToDateTime(
                                  TimeOfDay(hour: 16, minute: 5))) &&
                          DateTime.now().isAfter(
                              Common.convertTimeOfDayToDateTime(
                                  TimeOfDay(hour: 1, minute: 0))))) {
                        final snackBar = SnackBar(
                          content:
                              Text('No time slots are available for today'),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      walkInController.saveDataInDB(MobileUserDetails(
                          1,
                          null,
                          "Walk-in",
                          Common.convertDateTimeToString(DateTime.now()),
                          Common.convertDateTimeToString(DateTime.now()),
                          "DEMO",
                          int.parse(additionalMemberCon.text),
                          "DEMO",
                          "DEMO",
                          "DEMO",
                          "DEMO",
                          "DEMO",
                          "DEMO",
                          selectedTimeSlot,
                          selectedTimeSlot));
                    },
                    child: new Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight / 15,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
    );
  }
}
