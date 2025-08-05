import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_email_moderator_app/data/temp.dart';
import 'package:simple_email_moderator_app/logic/providers/organization_provider.dart';

import '../../utils/debug_print.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  final GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: [gmail.GmailApi.gmailModifyScope]);

  @override
  GoogleSignInAccount? build() => googleSignIn.currentUser;

  Future<GoogleSignInAccount?> _silentSignIn() async {
    try {
      if (googleSignIn.currentUser == null) {
        var account = await googleSignIn.signInSilently();
        return account;
      } else {
        return googleSignIn.currentUser;
      }
    } catch (error) {
      printInDebug(error.toString());
      return null;
    }
  }

  attemptSilentSignInAtStart() async => state = await _silentSignIn();

  Future<void> login() async {
    GoogleSignInAccount? account = await _silentSignIn();
    account ??= await googleSignIn.signIn();

    if (account != null) {
      state = googleSignIn.currentUser;
    } else {
      printInDebug('Login failed');
    }
  }

  Future<void> logout() async {
    await ref.read(organizationStateProvider.notifier).clear();
    orgOtp = null;
    await googleSignIn.signOut();
    state = null;
  }
}
