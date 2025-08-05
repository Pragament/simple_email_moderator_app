import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_email_moderator_app/data/models/org_otp_model.dart';
import 'package:simple_email_moderator_app/logic/providers/organization_provider.dart';
import 'package:simple_email_moderator_app/logic/providers/user_provider.dart';
import 'package:simple_email_moderator_app/presentation/widgets/my_snackbar.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  final int expTime = 20;
  OrgOtp? orgOtp;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Column(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            foregroundImage:
                (user.photoUrl != null && user.photoUrl!.isNotEmpty)
                    ? NetworkImage(user.photoUrl!)
                    : null,
          ),
          accountName: Text(user.displayName ?? 'User'),
          accountEmail: Text(user.email),
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: const Text('Generate OTP'),
          onTap: () async {
            final orgId = ref.read(organizationStateProvider)!.id;
            final userId = ref.read(userProvider)!.id;

            try {
              final moderatorDoc =
                  await FirebaseFirestore.instance
                      .collection('organizations')
                      .doc(orgId)
                      .collection('moderators')
                      .doc(userId)
                      .get();

              if (!moderatorDoc.exists ||
                  moderatorDoc.data()?['is_approved'] != true) {
                showSnackBar(
                  message: 'Access denied: You are not an approved moderator.',
                );
                return;
              }

              final code = _generateOtpCode();
              final created = DateTime.now();
              final id = FirebaseFirestore.instance.collection('temp').doc().id;
              final expiration = DateTime.now().add(Duration(minutes: expTime));

              final otp = OrgOtp(
                id: id,
                code: code,
                createdTimestamp: created,
                expirationTimestamp: expiration,
                orgId: orgId,
              );

              await FirebaseFirestore.instance
                  .collection('organizations')
                  .doc(orgId)
                  .collection('otps')
                  .doc(id)
                  .set(otp.toMap());

              orgOtp = otp;

              showSnackBar(message: 'Generated OTP');
            } catch (e) {
              showSnackBar(message: 'Failed to generate OTP: $e');
            }

            setState(() {});
          },
        ),
        if (orgOtp != null &&
            orgOtp!.expirationTimestamp.isAfter(DateTime.now()))
          ListTile(
            leading: const Text('OTP'),
            title: SelectableText(
              orgOtp!.code,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              '(${DateFormat('hh:mm a').format(orgOtp!.expirationTimestamp)})',
            ),
          ),
        const Divider(),
        const Spacer(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async => await ref.read(userProvider.notifier).logout(),
        ),
        const Divider(),
      ],
    );
  }

  String _generateOtpCode({int length = 6}) {
    final random = DateTime.now().millisecondsSinceEpoch.remainder(1000000);
    return random.toString().padLeft(length, '0');
  }
}
