import 'package:go_router/go_router.dart';
import 'core/service/storage/token.storage.dart';
import 'page/auth/forgot/forgot.page.dart';
import 'page/auth/login/login.page.dart';
import 'page/auth/register/register.page.dart';
import 'page/auth/terms/terms.page.dart';
import 'page/auth/splash/splash.page.dart';
import 'page/features/home/main_shell.page.dart';

class AppRouter {
  final ITokenStorage _tokenStorage;

  AppRouter(this._tokenStorage);

  late final GoRouter router = GoRouter(
    initialLocation: '/home',
    redirect: (context, state) async {
      final location = state.matchedLocation;

      final isSplash = location == '/';
      if (isSplash) return null;

      final token = await _tokenStorage.getToken();

      final authFormRoutes = {'/login', '/register', '/forgot', '/termsLogin'};
      final isInsideAuthForms = authFormRoutes.contains(location);
      if (token == null && !isInsideAuthForms) return '/login';
      if (token != null && isInsideAuthForms) return '/home';

      return null;
    },
    routes: [
      // AUTH ROUTES
      GoRoute(path: '/', builder: (context, state) => SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => ForgotPasswordPage(),
      ),
      GoRoute(path: '/termsLogin', builder: (context, state) => TermsPage()),

      // FEATURES ROUTES
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainShellView(),
      ),
    ],
  );
}
