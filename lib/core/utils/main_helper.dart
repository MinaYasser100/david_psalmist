import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHelper {
  static Future<bool> isLoginMethod() async {
    // Get the current Firebase user
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // Get the SharedPreferences instance
    final isLoginPref =
        SharedPrefHelper.instance.getBool(ConstantVariable.isLogin) ?? false;

    // If Firebase shows user is logged in but SharedPrefs doesn't, update SharedPrefs
    if (firebaseUser != null && !isLoginPref) {
      await SharedPrefHelper.instance.saveBool(ConstantVariable.isLogin, true);
      return true;
    }

    // If Firebase shows user is not logged in but SharedPrefs does, clear SharedPrefs
    if (firebaseUser == null && isLoginPref) {
      await SharedPrefHelper.instance.remove(ConstantVariable.isLogin);
      return false;
    }

    return firebaseUser != null && isLoginPref;
  }

  static checkLogin() {
    bool isLoginPref =
        SharedPrefHelper.instance.getBool(ConstantVariable.isLogin) ?? false;

    return isLoginPref;
  }
}
