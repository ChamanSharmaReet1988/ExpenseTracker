import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();
  late SharedPreferences _prefs;

  factory PreferencesHelper() {
    return _instance;
  }

  PreferencesHelper._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter and Setter for username
  String? get username => _prefs.getString('username');
  set username(String? value) {
    _prefs.setString('username', value ?? '');
  }

  // Getter and Setter for age
  int? get age => _prefs.getInt('age');
  set age(int? value) {
    _prefs.setInt('age', value ?? 0);
  }

  // Getter and Setter for isLoggedIn
  bool? get isLoggedIn => _prefs.getBool('isLoggedIn');
  set isLoggedIn(bool? value) {
    _prefs.setBool('isLoggedIn', value ?? false);
  }

  // Getter and Setter for currency
  String? get currency => _prefs.getString('currency');
  set currency(String? value) {
    _prefs.setString('currency', value ?? '');
  }

  // Method to remove all preferences
  Future<void> clear() async {
    await _prefs.clear();
  }
}
