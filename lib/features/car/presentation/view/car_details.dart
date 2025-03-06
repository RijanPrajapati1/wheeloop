import 'package:flutter/material.dart';
import 'package:wheeloop/features/booking/presentation/view/booking_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildReviewsList() {
    // Replace this with your logic to fetch reviews from your backend or API
    final reviews = [
      {'user': 'Anonymous', 'reviewText': 'Great car, very comfortable.'},
      {
        'user': 'Anonymous',
        'reviewText': 'Amazing experience! Highly recommended.'
      },
    ];

    // If no reviews are found, show the message 'No reviews yet.'
    if (reviews.isEmpty) {
      return const Text('No reviews yet.');
    }

    // Display the reviews in a list
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevent scrolling inside this list
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];

        return ListTile(
          title: Text(review['user'] ??
              'Anonymous'), // Provide fallback for null 'user'
          subtitle: Text(review['reviewText'] ??
              'No review text available'), // Provide fallback for null 'reviewText'
        );
      },
    );
  }
}
