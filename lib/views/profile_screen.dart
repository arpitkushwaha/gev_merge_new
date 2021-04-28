import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gev_app/controllers/login_controller.dart';
import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/preferences.dart';
import 'package:gev_app/utilities/webservice_manager.dart';
import 'package:gev_app/views/login.dart';

//Profile Screen.
//Screen to update user's profile.

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User userdetails;
  TextEditingController dateOfBirthCon = TextEditingController();
  DateTime dateOfBirth;
  Preferences preferences = Preferences();
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  @override
  void initState() {
    this.userdetails =
        User.fromJson(jsonDecode(preferences.getPreferences('user_info')));

    super.initState();
  }

  TextEditingController setInitialValues(String value) {
    TextEditingController initValController =
        TextEditingController(text: value);
    return initValController;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(userdetails.userName);
    _updateUserInfo(userdetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar('Profile'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20.0),
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
                    initialValue: userdetails.userName,
                    // controller: setInitialValues(userdetails.userName),
                    keyboardType: TextInputType.text,
                    decoration:
                        Common.buildInputDecoration(Icons.person_pin, "Name"),
                    onSaved: (value) {
                      userdetails.userName = value;
                    },
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextFormField(
                    initialValue: userdetails.userEmail,
                    // controller: setInitialValues(userdetails.userEmail),
                    keyboardType: TextInputType.emailAddress,
                    decoration: Common.buildInputDecoration(
                        Icons.email_outlined, "Email"),
                    onSaved: (value) {
                      userdetails.userEmail = value;
                    },
                    validator: (value) {
                      if (value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextFormField(
                    initialValue: userdetails.userPhone.toString(),
                    // controller:
                    //     setInitialValues(userdetails.userPhone.toString()),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      userdetails.userPhone = int.parse(value);
                    },
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
                    initialValue: userdetails.userAddress,
                    // controller: setInitialValues(userdetails.userAddress),
                    keyboardType: TextInputType.text,
                    decoration: Common.buildInputDecoration(
                        Icons.location_on, "Address"),
                    onSaved: (value) {
                      userdetails.userAddress = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextFormField(
                    initialValue: userdetails.userDob,
                    // controller: setInitialValues(userdetails.userDob),
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      pickupDateOfBirth();
                    },
                    decoration: Common.buildInputDecoration(
                        Icons.calendar_today_sharp, "Date-Of-Birth"),
                    onSaved: (value) {
                      userdetails.userDob = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                //   child: TextFormField(
                //     readOnly: true,
                //     decoration:
                //         Common.buildInputDecoration(Icons.translate, "English"),
                //     validator: null,
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: ButtonTheme(
                    minWidth: 150,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        _submit();
                        final snackBar = SnackBar(
                          content: Text('Profile Details Updated!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(Constant.buttonColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            side:
                                BorderSide(color: Color(Constant.buttonColor))),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ButtonTheme(
                    minWidth: 200,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        LogInController().logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            side:
                                BorderSide(color: Color(Constant.buttonColor))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickupDateOfBirth() async {
    DateTime dateOfBirthLoc = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year - 100,
        ),
        lastDate: DateTime(
          DateTime.now().year + 100,
        ));
    if (dateOfBirthLoc == null) {
      print(dateOfBirthLoc);
    } else {
      {
        setState(() {
          dateOfBirth = dateOfBirthLoc;
          dateOfBirthCon.text =
              "${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}";
        });
      }
    }
  }

  Future<void> _updateUserInfo(User userdetails) async {
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makePostRequestMap(
        'edit-user-info/${userdetails.id}', userdetails);
    print('response: ' + response['success'].toString());
  }
}
