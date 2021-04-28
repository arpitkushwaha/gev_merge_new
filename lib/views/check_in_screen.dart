import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/controllers/check_in_controller.dart';
import 'package:gev_app/models/mobile_user_details.dart';
import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/preferences.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/views/view_check_in_screen.dart';

// Check In Screen For User where he has to enter check-in details to get the passcode or to access the facilities.

class CheckInScreen extends StatefulWidget {
  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool isVisible = true;
  bool value = false;
  String nameStr;
  String passcode;
  DateTime checkOutDate;
  DateTime checkInDate;
  Preferences preferences = Preferences();
  // User user = User();
  String userPhone = '';
  TextEditingController checkInDateCon = TextEditingController();
  TextEditingController passcodeCon = TextEditingController();
  TextEditingController contactNumberCon = TextEditingController();
  TextEditingController checkOutDateCon = TextEditingController();
  MobileUserDetails mobileUserDetails = MobileUserDetails();
  CheckInController checkInController;

  //global key for validation
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  bool _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState.save();
    return true;
  }

  @override
  void initState() {
    super.initState();
    userPhone = preferences.getPreferences('phoneNo');
    contactNumberCon = TextEditingController(text: userPhone);
    User user =
        User.fromJson(jsonDecode(preferences.getPreferences('user_info')));
    print('name of user' + user.userName + user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    //Media Query
    SizeConfig().init(context);
    checkInController = CheckInController(context: context);
    // checkInController
    //     .feedbackNotification(DateTime.now().add(Duration(seconds: 2)));
    return Scaffold(
      appBar: Common.appBar('Check-In'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            height: SizeConfig.screenHeight - (SizeConfig.screenHeight / 9),
            width: SizeConfig.screenWidth,
            decoration: Common.background(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 10, right: 10, top: 10),
                    child: TextFormField(
                      controller: contactNumberCon,
                      keyboardType: TextInputType.phone,
                      enabled: false,
                      onChanged: (value) {
                        // userPhone = preferences.getPreferences('phoneNo');
                        // print('userphone' + userPhone);
                      },
                      decoration: Common.buildInputDecoration(
                          Icons.phone, "Contact Number"),
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value)) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 10, right: 10),
                      child: TextFormField(
                        controller: checkInDateCon,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          pickupDateCheckIn();
                        },
                        decoration: Common.buildInputDecoration(
                            Icons.calendar_today_sharp, "Check-In Date"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please fill the date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 10, right: 10),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please fill the date';
                          }
                          return null;
                        },
                        controller: checkOutDateCon,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          pickupDateCheckOut();
                        },
                        decoration: Common.buildInputDecoration(
                            Icons.calendar_today_sharp, "Check-out Date"),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                  ),
                  Visibility(
                    visible: !isVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 10, right: 10),
                      child: TextFormField(
                        controller: passcodeCon,
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                        decoration:
                            Common.buildInputDecoration(Icons.lock, "Passcode"),
                        readOnly: !value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Center(
                    child: ListTile(
                      leading: Checkbox(
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                            if (value == true) {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            } else {
                              setState(() {
                                isVisible = true;
                              });
                            }
                          });
                        },
                        activeColor: Colors.orangeAccent,
                        checkColor: Colors.white,
                      ),
                      title: Text(
                        'Already have Passcode?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 120,
                      height: 42,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () async {
                          if (_submit()) {
                            await checkInController
                                .saveUserAndMobileUserDetailsInPreferences(
                                    userPhone, mobileUserDetails);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCheckInScreen()),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        color: Color(Constant.buttonColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            side:
                                BorderSide(color: Color(Constant.buttonColor))),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  pickupDateCheckOut() async {
    DateTime checkOutDateLoc = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year - 5,
        ),
        lastDate: DateTime(
          DateTime.now().year + 5,
        ));
    if (checkOutDateLoc == null) {
      print(checkOutDateLoc);
    } else {
      {
        setState(() {
          checkOutDate = checkOutDateLoc;
          mobileUserDetails.checkOutDate = checkOutDate.toIso8601String();
          checkOutDateCon.text =
              "${checkOutDate.day}/${checkOutDate.month}/${checkOutDate.year}";
          print(checkOutDate);
        });
      }
    }
  }

  pickupDateCheckIn() async {
    DateTime checkInDateLoc = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year - 5,
        ),
        lastDate: DateTime(
          DateTime.now().year + 5,
        ));
    if (checkInDateLoc == null) {
      print(checkInDateLoc);
    } else {
      {
        setState(() {
          checkInDate = checkInDateLoc;
          mobileUserDetails.checkInDate = checkInDate.toIso8601String();
          checkInDateCon.text =
              "${checkInDate.day}/${checkInDate.month}/${checkInDate.year}";
          print(checkInDate);
        });
      }
    }
  }
}
