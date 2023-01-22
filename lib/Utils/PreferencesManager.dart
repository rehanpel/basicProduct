import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _singleton = PreferencesManager._internal();

  factory PreferencesManager() {
    return _singleton;
  }

  PreferencesManager._internal();

  SharedPreferences? pref;

  init({required Function onComplete}) async {
    pref ??= await SharedPreferences.getInstance();
    onComplete();
  }
}

extension PrefranceOnString on String {
  saveInPref(String key) {
    PreferencesManager().pref?.setString(key, this);
  }

  dynamic getFromPref() {
    return PreferencesManager().pref?.get(this);
  }
}

extension PrefranceOnBool on bool {
  saveInPref(String key) {
    PreferencesManager().pref?.setBool(key, this);
  }
}
