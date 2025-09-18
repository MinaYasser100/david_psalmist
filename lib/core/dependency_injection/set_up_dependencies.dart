import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/features/forgot_password/data/repo/forgot_password_repo_impl.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo_impl.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<FirebaseAuthErrorHandling>(
    FirebaseAuthErrorHandling(),
  );

  final sharedPrefHelper = await SharedPrefHelper.getInstance();
  getIt.registerSingleton<SharedPrefHelper>(sharedPrefHelper);

  getIt.registerSingleton<FirebaseFirestoreErrorHandler>(
    FirebaseFirestoreErrorHandler(),
  );

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
    ),
  );

  getIt.registerSingleton<ForgotPasswordRepoImpl>(
    ForgotPasswordRepoImpl(getIt<FirebaseAuthErrorHandling>()),
  );

  // // register connectivity cubit for internet
  // getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
