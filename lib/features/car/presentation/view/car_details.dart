import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/booking/presentation/view/booking_screen.dart';
import 'package:wheeloop/features/review/view_model/review_cubit.dart';
import 'package:wheeloop/features/review/view_model/review_state.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewCubit(
        dio: Dio(), // You can inject your Dio instance here if needed
        carId: car['id'], // Assuming you have a car ID
        userId: "user_id", // You should get the user ID from authentication
      )..fetchReviews(), // Fetch reviews when the screen is built
      child: Scaffold(
        appBar: AppBar(title: Text(car['name']!)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image (Ensures full image visibility)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 280, // Increased height for better visibility
                    width: double.infinity,
                    color: Colors.grey[200], // Placeholder background
                    child: Image.network(
                      car['image']!.replaceFirst("localhost",
                          "192.168.16.211"), // Replace with your laptop's IP address
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 50, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Car Name
                Text(
                  car['name']!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Price
                Text(
                  "Rs. ${car['price']}/day",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Type
                Text("Type: ${car['type']}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),

                // Transmission
                Text("Transmission: ${car['transmission']}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),

                // Description
                Text(
                  "Description: ${car['description'] ?? 'No details available'}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),

                // Reviews Section
                const Text(
                  'Reviews:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildReviewsList(),

                const SizedBox(height: 32),

                // Book Now Button (Navigates to BookingScreen)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(car: car),
                        ),
                      );
                    },
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewLoaded) {
          // If there are reviews
          if (state.reviews.isEmpty) {
            return const Text('No reviews yet.');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.reviews.length,
            itemBuilder: (context, index) {
              final review = state.reviews[index];

              return ListTile(
                title: Text(review['reviewText']),
                subtitle:
                    Text("By: ${review['userId']['email'] ?? 'Anonymous'}"),
              );
            },
          );
        } else if (state is ReviewError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text("No reviews available"));
      },
    );
  }
}
