import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo_impl.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<FirebaseAuthErrorHandling>(
    FirebaseAuthErrorHandling(),
  );

  getIt.registerSingleton<RegisterRepoImpl>(
    RegisterRepoImpl(errorHandling: getIt<FirebaseAuthErrorHandling>()),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(errorHandling: getIt<FirebaseAuthErrorHandling>()),
  );
  // // register connectivity cubit for internet
  // getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
