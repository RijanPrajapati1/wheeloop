import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/car/data/repository/car_repo.dart';
import 'package:wheeloop/features/car/presentation/view_model/car_screen_state.dart';

class CarCubit extends Cubit<CarState> {
  final CarRepository _carRepository;

  // Injecting the CarRepository through the constructor.
  CarCubit(this._carRepository) : super(CarState.initial());

  Future<void> fetchCars() async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));
    try {
      final cars = await _carRepository.getCars();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
