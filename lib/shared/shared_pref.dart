import 'package:shared_preferences/shared_preferences.dart';

class PASharedPref {
  static const String userTokenKey = 'TOKEN';
  static Future<String> getUserAccessToken() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey) ?? '';
  }

  static Future<void> setUserAccessToken(String token) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(PASharedPref.userTokenKey, token);
  }

  static Future<void> removeUserAccessToken() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(PASharedPref.userTokenKey, '');
  }
}
