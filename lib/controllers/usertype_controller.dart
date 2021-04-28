import 'package:gev_app/utilities/preferences.dart';

class UserType {
  Preferences preferences = Preferences();
  void setwalkInPref() async {
    preferences.setPreferences("usertype", "walk-In");
  }

  void setcheckInPref() async {
    preferences.setPreferences("usertype", "check-In");
  }

  void setskipUser() async {
    preferences.setPreferences("usertype", "skip");
  }

  String getdata() {
    var usertype;
    usertype = preferences.getPreferences("usertype");
    print(usertype);
    return usertype;
  }
}
