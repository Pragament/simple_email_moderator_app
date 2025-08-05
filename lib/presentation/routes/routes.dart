import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_email_moderator_app/presentation/pages/home_page.dart';
import 'package:simple_email_moderator_app/presentation/pages/login_page.dart';

part 'routes.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}
