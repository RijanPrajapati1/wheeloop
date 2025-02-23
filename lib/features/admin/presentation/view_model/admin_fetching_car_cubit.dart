import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/admin/domain/use_case/car_fetch_usecase.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_fetching_car_state.dart';

class AdminFetchCarCubit extends Cubit<AdminFetchCarState> {
  final GetAllCarsUseCase _getAllCarsUseCase;

  AdminFetchCarCubit(this._getAllCarsUseCase)
      : super(AdminFetchCarState.initial());

  Future<void> fetchCars() async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllCarsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (cars) {
        emit(state.copyWith(isLoading: false, cars: cars));
      },
    );
  }
}
