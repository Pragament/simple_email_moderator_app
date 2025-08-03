import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_email_moderator_app/utils/debug_print.dart';

import '../../data/models/organization_model.dart';

part 'organization_provider.g.dart';

@riverpod
class OrganizationState extends _$OrganizationState {
  late Box<Organization> _box;

  @override
  Organization? build() {
    _box = Hive.box<Organization>('orgBox');
    return _box.get('org');
  }

  Future<Organization?> load() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('organizations')
          .where('email_id', isEqualTo: 'tech.nikh.in@gmail.com')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final org = Organization.fromMap(doc.data());

        await update(org);
        return org;
      } else {
        return null;
      }
    } catch (e) {
      printInDebug('Error fetching organization: $e');
      return null;
    }
  }

  Future<void> update(Organization organization) async {
    await _box.put('org', organization);
    state = organization;
  }

  Future<void> clear() async {
    state = null;
    await _box.clear();
  }
}
