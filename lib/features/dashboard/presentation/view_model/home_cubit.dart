import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  // Method to update location
  void updateLocation(String location) {
    emit(state.copyWith(location: location));
  }

  // Method to update search text
  void updateSearchText(String searchText) {
    emit(state.copyWith(searchText: searchText));
  }

  // Method to change the selected index for BottomNavigationBar
  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
