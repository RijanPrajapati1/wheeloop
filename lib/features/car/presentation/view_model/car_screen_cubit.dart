import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/car/domain/repository/car_repo.dart';
import 'package:wheeloop/features/car/presentation/view_model/car_screen_state.dart';

class CarCubit extends Cubit<CarState> {
  final CarRepository _carRepository = CarRepository();

  CarCubit() : super(CarState.initial());

  Future<void> fetchCars() async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));
    try {
      final cars = await _carRepository.getAllCars();
      emit(state.copyWith(cars: cars, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
