import 'package:equatable/equatable.dart';
import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';

class AdminFetchCarState extends Equatable {
  final bool isLoading;
  final List<CarEntity> cars;
  final String? errorMessage;

  const AdminFetchCarState({
    required this.isLoading,
    required this.cars,
    this.errorMessage,
  });

  factory AdminFetchCarState.initial() => const AdminFetchCarState(
        isLoading: false,
        cars: [],
      );

  AdminFetchCarState copyWith({
    bool? isLoading,
    List<CarEntity>? cars,
    String? errorMessage,
  }) {
    return AdminFetchCarState(
      isLoading: isLoading ?? this.isLoading,
      cars: cars ?? this.cars,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, cars, errorMessage];
}
