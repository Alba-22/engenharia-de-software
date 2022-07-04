import 'package:go_router/go_router.dart';
import 'package:turistando/app/modules/entry/entry_page.dart';
import 'package:turistando/app/modules/login/login_page.dart';
import 'package:turistando/app/modules/register/register_page.dart';
import 'package:turistando/app/modules/splash/splash_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: "/entry",
      builder: (context, state) => const EntryPage(),
    ),
  ],
);
