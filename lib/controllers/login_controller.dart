import 'dart:convert';

import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/webservice_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInController {
  // Function for login.
  Future login(User user) async {
    print("${user.userPhone}");
    print(user.password);
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makeGetRequest(
        'fetch-user-info/?phone=${user.userPhone}&password=${user.password}');
    print("Response" + response.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response["user_info"] != null) {
      user = User.fromJson(response["user_info"][0]);
      prefs.setString('user_info', jsonEncode(user));
      prefs.setString('id', response["user_info"][0]["id"].toString());
      prefs.setString('username', user.userName.toString());
      prefs.setString('phoneNo', user.userPhone.toString());
      prefs.setString('isLoggedIn', "true");
      // print("You are logged in. DETAILS : phoneNo : ${user.userPhone}");
      print(jsonDecode(prefs.getString('user_info')));
    }

    print(prefs.getString('phoneNo'));
    if (prefs.getString('phoneNo') == user.userPhone.toString()) {
      prefs.setString('isLoggedIn', "true");
      print("You are logged in. DETAILS : phoneNo : ${user.userPhone}");
    }
    print(prefs.getString('phoneNo'));
    print(prefs.getString('isLoggedIn'));
  }

  // Function for logout.
  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print("You are logged out.");
  }
}
