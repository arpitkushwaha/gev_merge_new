import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gev_app/models/mobile_user_details.dart';
import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/preferences.dart';
import 'package:gev_app/utilities/size_config.dart';

// Screen to get the details of check in user.

class ViewCheckInScreen extends StatefulWidget {
  @override
  _ViewCheckInScreenState createState() => _ViewCheckInScreenState();
}

class _ViewCheckInScreenState extends State<ViewCheckInScreen> {
  String checkOutDateStr;
  DateTime checkOutDate;
  String checkInDateStr;
  DateTime checkInDate;
  TextEditingController name = TextEditingController();
  TextEditingController checkInDateCon = TextEditingController();
  TextEditingController checkOutDateCon = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController accomodationType = TextEditingController();
  TextEditingController checkinCode = TextEditingController();

  Preferences preferences = Preferences();

  //global key for validation
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  // void _validate() {
  //   _form.currentState.validate();
  // }
  @override
  void initState() {
    super.initState();
    User user =
    User.fromJson(jsonDecode(preferences.getPreferences('user_info')));
    MobileUserDetails mobileUserDetails = MobileUserDetails.fromJson(
        jsonDecode(preferences.getPreferences('mobile_user_details')));
    name = TextEditingController(text: user.userName);
    checkInDateCon = TextEditingController(text: mobileUserDetails.checkInDate);
    checkOutDateCon =
        TextEditingController(text: mobileUserDetails.checkOutDate);
    phone = TextEditingController(text: user.userPhone.toString());
    accomodationType =
        TextEditingController(text: mobileUserDetails.accommodationType);
    checkinCode = TextEditingController(text: mobileUserDetails.checkInCode);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: Common.appBar('View Check-In'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            //width: double.infinity,
            //height: double.infinity,
            decoration: Common.background(),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 10, right: 10, top: 30),
                    child: TextFormField(
                      controller: name,
                      readOnly: true,
                      decoration: Common.buildInputDecoration(
                          Icons.account_circle_outlined, "Full Name"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: phone,
                      readOnly: true,
                      decoration: Common.buildInputDecoration(
                          Icons.phone, "Contact Number"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: checkInDateCon,
                      readOnly: true,
                      decoration: Common.buildInputDecoration(
                          Icons.calendar_today_sharp, "Check-In Date"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: checkOutDateCon,
                      readOnly: true,
                      decoration: Common.buildInputDecoration(
                          Icons.calendar_today_sharp, "Check-Out Date"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: accomodationType,
                      readOnly: true,
                      decoration: Common.buildInputDecoration(
                          Icons.house_sharp, "Accommodation"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: checkinCode,
                      enabled: false,
                      //readOnly: true,
                      keyboardType: TextInputType.text,
                      decoration:
                      Common.buildInputDecoration(Icons.lock, "Code"),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
