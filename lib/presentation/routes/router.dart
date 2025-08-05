import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_email_moderator_app/logic/providers/user_provider.dart';
import 'package:simple_email_moderator_app/presentation/routes/routes.dart';

final routerProvider = Provider(
  (ref) {
    var user = ref.watch(userProvider);

    return GoRouter(
      initialLocation: '/',
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        // If the user is not logged in and not on the Login screen, redirect to Login
        if (user == null && state.uri.path != '/login') {
          return '/login';
        }

        // If the user is logged in and on the Login screen, redirect to home
        if (user != null &&
            (state.uri.path == '/login' || state.uri.path == '/')) {
          return '/home';
        }

        // No redirect needed
        return null;
      },
    );
  },
);
