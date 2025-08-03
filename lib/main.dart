import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_email_moderator_app/constants.dart';
import 'package:simple_email_moderator_app/logic/providers/user_provider.dart';
import 'package:simple_email_moderator_app/presentation/routes/router.dart';

import 'data/models/organization_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(OrganizationAdapter());

  await Hive.openBox<Organization>('orgBox');

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme({bool isDark = false}) => ColorScheme.fromSeed(
      seedColor: Colors.yellow,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    ref.read(userProvider.notifier).attemptSilentSignInAtStart();

    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData.from(colorScheme: colorScheme(), useMaterial3: true),
      darkTheme: ThemeData.from(
          colorScheme: colorScheme(isDark: true), useMaterial3: true),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
