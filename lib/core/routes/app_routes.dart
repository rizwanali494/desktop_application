import 'package:desktop_application/core/features/views/auth/login_view.dart';
import 'package:desktop_application/core/features/views/auth/sign_up.dart';
import 'package:desktop_application/core/features/views/splash_view.dart';
import 'package:desktop_application/core/routes/routes.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: Routes.splash.name,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/login',
        name: Routes.login.name,
        builder: (context, state) => const LoginView(),
      ),
       GoRoute(
        path: '/signup',
        name: Routes.signup.name,
        builder: (context, state) => const SignUpView(),
      ),
      // GoRoute(
      //     path: '/message1',
      //     name: Routes.message1.name,
      //     builder: (context, state) {
      //       final text = state.extra as String;
      //       return Message1(
      //         text: text,
      //       );
      //     }),
    ],
  );
}
