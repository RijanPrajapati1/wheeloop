import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
              // ✅ Car Image (Ensures full image visibility)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 280, // Increased height for better visibility
                  width: double.infinity,
                  color: Colors.grey[200], // Placeholder background
                  child: Image.network(
                    car['image']!.replaceFirst("localhost", "10.0.2.2"),
                    fit: BoxFit.contain, // ✅ Ensures full image is visible
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Car Name
              Text(
                car['name']!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // ✅ Star Rating
              RatingBarIndicator(
                rating: (car['rating'] ?? 0).toDouble(),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 20,
                direction: Axis.horizontal,
              ),
              const SizedBox(height: 16),

              // ✅ Price
              Text(
                "Rs. ${car['price']}/day",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // ✅ Type
              Text("Type: ${car['type']}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),

              // ✅ Transmission
              Text("Transmission: ${car['transmission']}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),

              // ✅ Description
              Text(
                "Description: ${car['description'] ?? 'No details available'}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),

              // ✅ Book Now Button (Navigates to BookingScreen)
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
}
