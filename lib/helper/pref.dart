
import 'package:hive_flutter/adapters.dart';

class Pref {
  static late Box _box;

  static Future<void> initialize() async {
   await Hive.initFlutter();
    _box = await Hive.openBox('myData');
  }

  static bool get showOnboarding =>
      _box.get('showOnboarding', defaultValue: true);
  static set showOnboarding(bool v) => _box.put('showOnboarding', v);
}
