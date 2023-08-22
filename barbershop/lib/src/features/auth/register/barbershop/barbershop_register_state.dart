// ignore_for_file: public_member_api_docs, sort_constructors_first
enum BarbershopRegisterStatus {
  initial,
  error,
  success,
}

class BarbershopRegisterState {
  const BarbershopRegisterState({
    required this.openingDays,
    required this.openingHours,
    required this.status,
  });
  const BarbershopRegisterState.initial()
      : this(
          status: BarbershopRegisterStatus.initial,
          openingDays: const [],
          openingHours: const [],
        );

  final BarbershopRegisterStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopRegisterState copyWith({
    BarbershopRegisterStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return BarbershopRegisterState(
      status: status ?? this.status,
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
