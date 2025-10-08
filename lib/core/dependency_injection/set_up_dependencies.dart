import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/features/class_view/data/repo/scanner_repo.dart';
import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:david_psalmist/features/class_view/data/repo/students_class_repo.dart';
import 'package:david_psalmist/features/class_view/data/services/student_firebase_services.dart';
import 'package:david_psalmist/features/class_view/data/services/students_class_services.dart';
import 'package:david_psalmist/features/classes/data/repo/classes_repo_impl.dart';
import 'package:david_psalmist/features/forgot_password/data/repo/forgot_password_repo_impl.dart';
import 'package:david_psalmist/features/home/data/repo/level_repo_impl.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo_impl.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo_impl.dart';
import 'package:david_psalmist/features/verfiy_email/data/repo/verify_email_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<FirebaseAuthErrorHandling>(
    FirebaseAuthErrorHandling(),
  );

  getIt.registerSingleton<SharedPrefHelper>(SharedPrefHelper.instance);

  getIt.registerSingleton<FirebaseFirestoreErrorHandler>(
    FirebaseFirestoreErrorHandler(),
  );

  getIt.registerSingleton<UserHiveHelper>(UserHiveHelper());

  getIt.registerSingleton<RegisterRepoImpl>(
    RegisterRepoImpl(
      errorHandling: getIt<FirebaseAuthErrorHandling>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      errorHandling: getIt<FirebaseAuthErrorHandling>(),
      sharedPrefHelper: getIt<SharedPrefHelper>(),
      userHiveHelper: getIt<UserHiveHelper>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  getIt.registerSingleton<ForgotPasswordRepoImpl>(
    ForgotPasswordRepoImpl(getIt<FirebaseAuthErrorHandling>()),
  );

  getIt.registerSingleton<VerifyEmailRepoImpl>(
    VerifyEmailRepoImpl(errorHandling: getIt<FirebaseAuthErrorHandling>()),
  );

  getIt.registerSingleton<LevelRepoImpl>(
    LevelRepoImpl(getIt<FirebaseFirestoreErrorHandler>()),
  );

  getIt.registerSingleton<ClassesRepoImpl>(
    ClassesRepoImpl(getIt<FirebaseFirestoreErrorHandler>()),
  );

  getIt.registerSingleton<ScannerRepoImpl>(ScannerRepoImpl());
  //Student Firebase Services
  getIt.registerSingleton<StudentFirebaseServices>(StudentFirebaseServices());
  // students class services (provides snapshots for students in a class)
  getIt.registerSingleton<StudentsClassServices>(StudentsClassServices());
  // student repo impl
  getIt.registerSingleton<StudentRepoImpl>(
    StudentRepoImpl(
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
      studentFirebaseServices: getIt<StudentFirebaseServices>(),
    ),
  );
  // Students Class Repo Impl
  getIt.registerSingleton<StudentsClassRepoImpl>(
    StudentsClassRepoImpl(
      studentsClassServices: getIt<StudentsClassServices>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  // // register connectivity cubit for internet
  // getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
