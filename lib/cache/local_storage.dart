import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;
  static Future<SharedPreferences?> getInstance() async {
    _preferences = _preferences ?? await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future<String> getToken() async {
    try {
      await getInstance();
      var language = _preferences!.getString("access_token");
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<void> clearCache() async {
    try {
      await getInstance();
      _preferences!.clear();
    } catch (e) {
      return;
    }
  }

  static Future<String> getId() async {
    try {
      await getInstance();
      var language = _preferences!.getString('userId');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getUserId() async {
    try {
      await getInstance();
      var language = _preferences!.getString('user_id');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getName() async {
    try {
      await getInstance();
      var language = _preferences!.getString('userName');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getfcm() async {
    try {
      await getInstance();
      var language = _preferences!.getString('fcm_token');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getandroiddevicetoken() async {
    try {
      await getInstance();
      var language = _preferences!.getString('androiddevice_token');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getiosdevicetoken() async {
    try {
      await getInstance();
      var language = _preferences!.getString('iosdevice_tokens');
      return language!;
    } catch (e) {
      return '';
    }
  }

  static Future<String> getcustomerId() async {
    try {
      await getInstance();
      var language = _preferences!.getString('customerId');
      return language!;
    } catch (e) {
      return '';
    }
  }
}
