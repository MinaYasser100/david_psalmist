import 'package:hive_flutter/hive_flutter.dart';

class LanguageCacheHelper {
  static const String languageBoxName = 'languageBox';
  static const String languageCodeKey = 'languageCode';

  static late Box _languageBox;

  static Future<void> init() async {
    _languageBox = await Hive.openBox(languageBoxName);
  }

  static Future<void> cacheLanguageCode(String languageCode) async {
    await _languageBox.put(languageCodeKey, languageCode);
  }

  static String? getCachedLanguageCode() {
    return _languageBox.get(languageCodeKey);
  }
}
