import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/review/view_model/review_cubit.dart';
import 'package:wheeloop/features/review/view_model/review_state.dart';

class ReviewScreen extends StatelessWidget {
  final String carId;
  final String userId;

  const ReviewScreen({super.key, required this.carId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewCubit(
        dio: Dio(), // You can inject your Dio instance here if needed
        carId: carId,
        userId: userId,
      )..fetchReviews(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Reviews")),
        body: BlocBuilder<ReviewCubit, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReviewLoaded) {
              return Column(
                children: [
                  // Submit Review Section
                  TextField(
                    onChanged: (text) {
                      // Optional: You could add logic to update the review text in the state
                    },
                    decoration: const InputDecoration(
                      labelText: "Write your review",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // You would call the submitReview method here with the text from the TextField
                    },
                    child: const Text("Submit Review"),
                  ),
                  const SizedBox(height: 20),

                  // Display Reviews
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return ListTile(
                          title: Text(review['reviewText']),
                          subtitle: Text(
                              "By: ${review['userId']['email'] ?? 'Anonymous'}"),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ReviewError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}
