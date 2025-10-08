import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/routing/app_router.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/core/utils/theme_data_func.dart';
import 'package:david_psalmist/features/class_view/data/repo/scanner_repo.dart';
import 'package:david_psalmist/features/class_view/data/repo/students_class_repo.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/classes/data/repo/classes_repo_impl.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:david_psalmist/features/home/data/repo/level_repo_impl.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies
  setupDependencies();

  await EasyLocalization.ensureInitialized();

  await UserHiveHelper.init();
  var providers = [
    BlocProvider(create: (context) => LevelCubit(getIt<LevelRepoImpl>())),
    BlocProvider(create: (context) => ClassesCubit(getIt<ClassesRepoImpl>())),
    BlocProvider(
      create: (context) =>
          ScannerCubit(getIt<ScannerRepoImpl>(), getIt<StudentRepoImpl>()),
    ),
    BlocProvider(
      create: (context) => StudentsClassCubit(getIt<StudentsClassRepoImpl>()),
    ),
  ];
  runApp(
    MultiBlocProvider(
      providers: providers,
      child: EasyLocalization(
        supportedLocales: const [
          Locale(ConstantVariable.englishLangCode),
          Locale(ConstantVariable.arabicLangCode),
        ],
        path: 'assets/localization',
        fallbackLocale: const Locale(ConstantVariable.englishLangCode),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: themeDataFunc(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
