import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Map<String, dynamic>> reviews;
  final String userReview;

  const ReviewLoaded({required this.reviews, required this.userReview});

  @override
  List<Object?> get props => [reviews, userReview];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({required this.message});

  @override
  List<Object?> get props => [message];
}
