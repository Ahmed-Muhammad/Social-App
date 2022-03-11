import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static SharedPreferences? sharedPreferences;


//---------- shared Preferences --> Initialization ------------
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //---------- GET Data --> from onBoarding & token ------------
  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }


//---------- Save Data --> onBoarding screen info ------------
  static Future<bool?> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences?.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences?.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences?.setBool(key, value);
    } else {
      return await sharedPreferences?.setDouble(key, value);
    }
  }

//---------- Remove Data --> from onBoarding & token ------------
  static Future<bool?> removeData({
    required String key,
  }) async {
    return await sharedPreferences?.remove(key);
  }
}


/*  static Future<bool?> putBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences?.setBool(key, value);
  }*/
/*static bool? getBool({
    required String key,
  }) {
    return sharedPreferences?.getBool(key);
  }*/
