import 'package:equatable/equatable.dart';
import 'package:wheeloop/features/car/data/model/car_model.dart';

class CarState extends Equatable {
  final List<CarModel> cars;
  final bool isLoading;
  final String errorMessage;

  const CarState({
    required this.cars,
    required this.isLoading,
    required this.errorMessage,
  });

  // Initial state
  static CarState initial() {
    return const CarState(
      cars: [],
      isLoading: false,
      errorMessage: "",
    );
  }

  // Copy method for updating the state
  CarState copyWith({
    List<CarModel>? cars,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CarState(
      cars: cars ?? this.cars,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cars, isLoading, errorMessage];
}
