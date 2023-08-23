// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RestClientRef = ProviderRef<RestClient>;
String _$userRepoHash() => r'b51a28f3a24c6aa93bbdc2f4b5b8dec8411da605';

/// See also [userRepo].
@ProviderFor(userRepo)
final userRepoProvider = Provider<UserRepository>.internal(
  userRepo,
  name: r'userRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepoRef = ProviderRef<UserRepository>;
String _$userLoginServiceHash() => r'a483bbebc405eae496ab9aa56d43401e25adc507';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<UserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserLoginServiceRef = ProviderRef<UserLoginService>;
String _$getMeHash() => r'b0827e3401f72f6b6d75077ccf6841b3f204beb2';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMeRef = FutureProviderRef<UserModel>;
String _$barbershopRepoHash() => r'86f66ec599ab249c80a9dbb36263bdeed1b5d2ec';

/// See also [barbershopRepo].
@ProviderFor(barbershopRepo)
final barbershopRepoProvider = Provider<BarbershopRepository>.internal(
  barbershopRepo,
  name: r'barbershopRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$barbershopRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BarbershopRepoRef = ProviderRef<BarbershopRepository>;
String _$getMyBarbershopHash() => r'b202cefd1ca4e2c8c6e0add0fcb739fd527181dd';

/// See also [getMyBarbershop].
@ProviderFor(getMyBarbershop)
final getMyBarbershopProvider = FutureProvider<BarbershopModel>.internal(
  getMyBarbershop,
  name: r'getMyBarbershopProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyBarbershopHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyBarbershopRef = FutureProviderRef<BarbershopModel>;
String _$logoutHash() => r'842c051b3cead0794693170f06dc3ab1b518f795';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
