import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final  _LoggedIn = "_LoggedIn";
  final  _guestToken = "_token";
  final  _userId = "_userId";
  final _registertoken = '_regtoken';

  getAllPrefsClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("_LoggedIn");
    prefs.remove("_guestToken");
    prefs.remove("_userId");
    prefs.remove("_registertoken");
    prefs.clear();
  }


  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_LoggedIn) ?? false;
  }
  Future setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_LoggedIn, value);
  }
//gest token
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_guestToken) ?? '';
  }

  Future setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_guestToken, value);
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId) ?? 0;
  }
  Future setUserId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_userId, value);
  }

  //register token

  Future<String> getregToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registertoken) ?? '0';
  }

  Future setregToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_registertoken, value);
  }

}