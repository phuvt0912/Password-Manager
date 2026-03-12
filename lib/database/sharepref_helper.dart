import 'package:shared_preferences/shared_preferences.dart';

class Shareprefshelper {
  static Future<void> changeThemeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Setting the value of isDarkMode to the opposite of its current value, or false if it doesn't exist as initial value
    await prefs.setBool('isDarkMode', prefs.containsKey('isDarkMode') ? !prefs.getBool('isDarkMode')! : false);
  }

  static Future<bool> getThemeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get( 'isDarkMode') as bool? ?? false; 
  }
}