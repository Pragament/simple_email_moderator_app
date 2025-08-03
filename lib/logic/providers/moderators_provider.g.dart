// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderators_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsHash() => r'08fa631e8dede406ff8be18bc460ef480a8fedcb';

/// See also [Accounts].
@ProviderFor(Accounts)
final accountsProvider = NotifierProvider<Accounts, List<Moderator>?>.internal(
  Accounts.new,
  name: r'accountsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Accounts = Notifier<List<Moderator>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
