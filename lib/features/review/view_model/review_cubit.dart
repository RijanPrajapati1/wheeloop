import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart'; // Adjust this based on your API

import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final Dio dio;
  final String carId;
  final String userId;

  ReviewCubit({required this.dio, required this.carId, required this.userId})
      : super(ReviewLoading());

  // Fetch all reviews for a car
  Future<void> fetchReviews() async {
    try {
      emit(ReviewLoading());
      final response = await dio.get("${ApiEndpoints.baseUrl}/review/$carId");

      if (response.statusCode == 200) {
        final reviews = response.data['reviews'];
        await fetchUserReview(); // Fetch user review after fetching all reviews
        emit(ReviewLoaded(
            reviews: List<Map<String, dynamic>>.from(reviews), userReview: ""));
      } else {
        emit(const ReviewError(message: "Failed to load reviews"));
      }
    } catch (e) {
      emit(ReviewError(message: e.toString()));
    }
  }

  // Fetch the user's review for this car
  Future<void> fetchUserReview() async {
    try {
      final response = await dio
          .get("${ApiEndpoints.baseUrl}/review/user/$userId/car/$carId");

      if (response.statusCode == 200) {
        final userReview = response.data['reviewText'] ?? '';
        emit(ReviewLoaded(reviews: const [], userReview: userReview));
      }
    } catch (e) {
      // Handle error gracefully, user may not have reviewed yet
    }
  }

  // Submit or update the review
  Future<void> submitReview(String reviewText) async {
    try {
      final response = await dio.post("/review/submit", data: {
        "userId": userId,
        "carId": carId,
        "reviewText": reviewText,
      });

      if (response.statusCode == 200) {
        fetchReviews(); // Refresh reviews after submission
      }
    } catch (e) {
      emit(ReviewError(message: "Error submitting review: ${e.toString()}"));
    }
  }
}
