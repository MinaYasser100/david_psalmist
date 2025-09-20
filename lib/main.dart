import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/routing/app_router.dart';
import 'package:david_psalmist/core/utils/theme_data_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies
  setupDependencies();

  await UserHiveHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: themeDataFunc(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
