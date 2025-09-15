import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHelper {
  static Future<bool> isLoginMethod() async {
    // Get the current Firebase user
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // Get the SharedPreferences instance
    final prefs = await SharedPrefHelper.getInstance();
    final isLoginPref = prefs.getBool(ConstantVariable.isLogin) ?? false;

    // If Firebase shows user is logged in but SharedPrefs doesn't, update SharedPrefs
    if (firebaseUser != null && !isLoginPref) {
      await prefs.saveBool(ConstantVariable.isLogin, true);
      await prefs.saveString(ConstantVariable.uId, firebaseUser.uid);
      return true;
    }

    // If Firebase shows user is not logged in but SharedPrefs does, clear SharedPrefs
    if (firebaseUser == null && isLoginPref) {
      await prefs.remove(ConstantVariable.isLogin);
      await prefs.remove(ConstantVariable.uId);
      return false;
    }

    return firebaseUser != null && isLoginPref;
  }
}
