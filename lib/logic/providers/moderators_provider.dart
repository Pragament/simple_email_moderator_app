import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_email_moderator_app/data/models/moderator_model.dart';
import 'package:simple_email_moderator_app/logic/providers/organization_provider.dart';

part 'moderators_provider.g.dart';

@Riverpod(keepAlive: true)
class Accounts extends _$Accounts {
  final _firestore = FirebaseFirestore.instance;

  @override
  List<Moderator>? build() => null;

  Future<void> load() async {
    final orgId = ref.read(organizationStateProvider)!.id;

    final snapshot = await _firestore
        .collection('organizations')
        .doc(orgId)
        .collection('moderators')
        .get();

    final moderators = snapshot.docs
        .map((doc) => Moderator.fromMap(doc.data()))
        .toList();

    state = moderators;
  }

  void clear() => state = null;
}
