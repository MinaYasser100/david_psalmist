import 'package:david_psalmist/core/routing/animation_route.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/main_helper.dart';
import 'package:david_psalmist/features/forgot_password/ui/forgot_password_view.dart';
import 'package:david_psalmist/features/home/ui/home_view.dart';
import 'package:david_psalmist/features/login/ui/login_view.dart';
import 'package:david_psalmist/features/register/ui/register_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: MainHelper.checkLogin()
        ? Routes.homeView
        : Routes.loginView,
    routes: [
      // Register view
      GoRoute(
        path: Routes.registerView,
        pageBuilder: (context, state) => fadeTransitionPage(RegisterView()),
      ),
      // Login view
      GoRoute(
        path: Routes.loginView,
        pageBuilder: (context, state) => fadeTransitionPage(LoginView()),
      ),
      // Home view
      GoRoute(
        path: Routes.homeView,
        pageBuilder: (context, state) => fadeTransitionPage(HomeView()),
      ),
      // Forgot Password
      GoRoute(
        path: Routes.forgotPasswordView,
        pageBuilder: (context, state) =>
            fadeTransitionPage(ForgotPasswordView()),
      ),

      // GoRoute(
      //   path: Routes.productDetails,
      //   pageBuilder: (context, state) {
      //     final product = state.extra as Product?;
      //     if (product == null) throw Exception('Product not found');
      //     return fadeTransitionPage(ProductDetailsView(product: product));
      //   },
      // ),
    ],
  );
}

// Future<String> getFirstScreen() async {
//   final isOnboardingSeen = OnboardingHive().isOnboardingSeen();
//   if (!isOnboardingSeen) {
//     return Routes.onboarding;
//   }
//   // Ensure MonitoringSystemHiveService is ready
//   final monitoringService =
//       await GetIt.I.getAsync<MonitoringSystemHiveService>();
//   final farmOwnerStatus = monitoringService.getFarmOwnerStatus();

//   if (farmOwnerStatus == null) {
//     return Routes.userTypeSelectionScreen;
//   } else if (!farmOwnerStatus) {
//     return Routes.layoutScreens;
//   } else if (farmOwnerStatus &&
//       monitoringService.getFarmerSelectedPlants().isEmpty) {
//     return Routes.plantsSelectionScreen;
//   } else {
//     return Routes.layoutScreens;
//   }
// }
