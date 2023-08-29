// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_employee_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotalSchedulesHash() => r'b7a6735f9853d7e2e618c6d13b40dee400c5c888';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetTotalSchedulesRef = AutoDisposeFutureProviderRef<int>;

/// See also [getTotalSchedules].
@ProviderFor(getTotalSchedules)
const getTotalSchedulesProvider = GetTotalSchedulesFamily();

/// See also [getTotalSchedules].
class GetTotalSchedulesFamily extends Family<AsyncValue<int>> {
  /// See also [getTotalSchedules].
  const GetTotalSchedulesFamily();

  /// See also [getTotalSchedules].
  GetTotalSchedulesProvider call(
    int userId,
  ) {
    return GetTotalSchedulesProvider(
      userId,
    );
  }

  @override
  GetTotalSchedulesProvider getProviderOverride(
    covariant GetTotalSchedulesProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getTotalSchedulesProvider';
}

/// See also [getTotalSchedules].
class GetTotalSchedulesProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getTotalSchedules].
  GetTotalSchedulesProvider(
    this.userId,
  ) : super.internal(
          (ref) => getTotalSchedules(
            ref,
            userId,
          ),
          from: getTotalSchedulesProvider,
          name: r'getTotalSchedulesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalSchedulesHash,
          dependencies: GetTotalSchedulesFamily._dependencies,
          allTransitiveDependencies:
              GetTotalSchedulesFamily._allTransitiveDependencies,
        );

  final int userId;

  @override
  bool operator ==(Object other) {
    return other is GetTotalSchedulesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
