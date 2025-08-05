import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_email_moderator_app/logic/providers/moderators_provider.dart';
import 'package:simple_email_moderator_app/logic/providers/organization_provider.dart';
import 'package:simple_email_moderator_app/presentation/widgets/my_drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    fetch();

    super.initState();
  }

  fetch() async {
    if (ref.read(organizationStateProvider) == null) {
      var organization =
      await ref.read(organizationStateProvider.notifier).load();
      if (organization != null) {
        await ref.read(accountsProvider.notifier).load();
      }
    } else {
      await ref.read(accountsProvider.notifier).load();
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Pragament Moderator'),
        centerTitle: true,
      ),
      drawer: const Drawer(child: MyDrawer()),
    );
  }
}
