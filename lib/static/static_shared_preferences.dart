import 'package:shared_preferences/shared_preferences.dart';

class UserStoragePreferences {
  static Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }
}
