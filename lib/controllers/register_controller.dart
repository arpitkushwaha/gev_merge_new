import 'dart:convert';

import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/webservice_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  // Preferences preferences;
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // Function for user registration.
  Future register(User user) async {
    WebserviceManager wsm = new WebserviceManager();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var queryparams = {
      'name': user.userName,
      'country_code': user.userPhoneCountryCode,
      'phone': user.userPhone,
      'email': user.userEmail,
      'address': user.userAddress,
      'password': user.password,
      'dob': user.userDob
    };
    print(queryparams);
    Map<dynamic, dynamic> response =
        await wsm.makePostRequestMap('add-user-info', queryparams);
    print("Response" + response.toString());
    if (response['success'] != "") {
      prefs.setString('isValidWalkin', 'true');
    }

    prefs.setString('name', user.userName);
    prefs.setString('name', user.userName);
    prefs.setString('phoneNo', user.userPhone.toString());
    prefs.setString('email', user.userEmail);

    print(
        "You are registered. DETAILS : username : ${user.userName}, phoneNo : ${user.userPhone}, email : ${user.userEmail}");
  }
}
