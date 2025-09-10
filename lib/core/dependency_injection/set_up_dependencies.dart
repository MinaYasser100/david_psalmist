import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // register singletons
  // register dio helper
  //getIt.registerSingleton<DioHelper>(DioHelper());
  // register product repo
  // getIt.registerSingleton<ProductRepoImpl>(ProductRepoImpl());
  // // register connectivity cubit for internet
  // getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
