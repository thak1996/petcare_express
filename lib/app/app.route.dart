import 'package:go_router/go_router.dart';
import 'core/service/storage/token.storage.dart';
import 'page/auth/forgot/forgot.page.dart';
import 'page/auth/login/login.page.dart';
import 'page/auth/register/register.page.dart';
import 'page/auth/terms/terms.page.dart';
import 'page/auth/splash/splash.page.dart';
import 'page/features/home/home.page.dart';

class AppRouter {
  final ITokenStorage _tokenStorage;

  AppRouter(this._tokenStorage);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final String? token = await _tokenStorage.getToken();
      final bool isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/forgot';

      if (token == null) {
        return isLoggingIn ? null : '/login';
      }
      if (isLoggingIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(path: '/termsLogin', builder: (context, state) => TermsPage()),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => ForgotPasswordPage(),
      ),
    ],
  );
}
