import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String location;
  final String searchText;
  final int selectedIndex;

  const HomeState({
    required this.location,
    required this.searchText,
    required this.selectedIndex,
  });

  // Factory method for initial state
  static HomeState initial() {
    return const HomeState(
      location: 'Bhaktapur, Nepal', // Default location
      searchText: '',
      selectedIndex: 0, // Default selected index
    );
  }

  // Copy method to update specific properties
  HomeState copyWith({
    String? location,
    String? searchText,
    int? selectedIndex,
  }) {
    return HomeState(
      location: location ?? this.location,
      searchText: searchText ?? this.searchText,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [location, searchText, selectedIndex];
}
