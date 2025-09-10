import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../caching/hive/language_cache_helper.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<ChangeLanguageState> {
  LanguageCubit() : super(ChangeLanguageState(locale: getInitialLocale()));

  /// Get initial locale when cubit is created
  static Locale getInitialLocale() {
    final String? cachedLanguageCode =
        LanguageCacheHelper.getCachedLanguageCode();
    if (cachedLanguageCode != null) {
      return Locale(cachedLanguageCode);
    } else {
      return Locale(PlatformDispatcher.instance.locale.languageCode);
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper.cacheLanguageCode(languageCode);
    emit(ChangeLanguageState(locale: Locale(languageCode)));
  }
}
