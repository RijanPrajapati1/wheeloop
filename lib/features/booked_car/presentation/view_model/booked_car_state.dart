import 'package:equatable/equatable.dart';

abstract class BookedCarState extends Equatable {
  const BookedCarState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookedCarState {}

class BookingLoading extends BookedCarState {}

class BookingLoaded extends BookedCarState {
  final List bookings;

  const BookingLoaded({required this.bookings});

  @override
  List<Object?> get props => [bookings];
}

class BookingError extends BookedCarState {
  final String message;

  const BookingError({required this.message});

  @override
  List<Object?> get props => [message];
}
