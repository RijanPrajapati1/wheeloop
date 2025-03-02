import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wheeloop/features/car/presentation/view/car_details.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final Dio _dio = Dio();
  final String baseUrl = "http://10.0.2.2:3001/api/car/findAll";

  List<Map<String, dynamic>> cars = [];
  List<Map<String, dynamic>> suggestedCars = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  // ✅ Fetch Cars from Backend
  Future<void> fetchCars() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> fetchedCars =
            List<Map<String, dynamic>>.from(response.data);

        setState(() {
          cars = fetchedCars;
          suggestedCars = _getRandomSuggestions(fetchedCars);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch cars");
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching cars: $e";
        isLoading = false;
      });
    }
  }

  // ✅ Get 3 random suggested cars
  List<Map<String, dynamic>> _getRandomSuggestions(
      List<Map<String, dynamic>> allCars) {
    final random = Random();
    List<Map<String, dynamic>> shuffledCars = List.from(allCars)
      ..shuffle(random);
    return shuffledCars.take(3).toList(); // Pick first 3 random cars
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "All Cars",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CarListScreen(cars: cars)),
                              );
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ✅ "All Cars" Section
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];

                          return _buildCarCard(context, car);
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ✅ "Suggested for You" Section
                    if (suggestedCars.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Suggested for You",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: suggestedCars.length,
                          itemBuilder: (context, index) {
                            final car = suggestedCars[index];
                            return _buildCarCard(context, car);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              );
  }

  // ✅ Car Card Widget (Images Properly Fitted)
  Widget _buildCarCard(BuildContext context, Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailScreen(car: car),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 140, // ✅ Reduced height slightly
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RatingBarIndicator(
                      rating: (car['rating'] ?? 0).toDouble(),
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 18,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rs. ${car['price']}/day",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Car List Screen
class CarListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cars;

  const CarListScreen({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Cars")),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CarDetailScreen(car: car)),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12)),
                    child: Image.network(
                      car['image']!.replaceFirst("localhost", "10.0.2.2"),
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 50, color: Colors.red),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        car['name']!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Rs. ${car['price']}/day",
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
