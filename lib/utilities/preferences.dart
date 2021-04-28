import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static String userKey = 'user_key';
  static String mobileUserDetailsKey = 'mobile_user_details_key';

  //To intialize the preferences.
  static void initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  //To set the preferences.
  void setPreferences(String key, String value) {
    //initialize();
    prefs.setString(key, value);
  }

  // To get the preferences.
  String getPreferences(String key) {
    //initialize();
    return prefs.getString(key);
  }
}
