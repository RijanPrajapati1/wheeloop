import 'package:flutter/material.dart';
import 'package:wheeloop/screen/car_screen/brand_screen.dart';
import 'package:wheeloop/screen/car_screen/car_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Location Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your location",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Bhaktapur, Nepal",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat Bold',
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(
                        'assets/images/car_splash.png'), // Add profile image
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Search Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Your Favorite Vehicle",
                        filled: true,
                        fillColor: Colors.grey[120],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Top Brands Section

            const SizedBox(height: 10),
            const BrandScreen(),
            const SizedBox(height: 20),
            // All Cars Section

            const SizedBox(height: 10),
            const CarScreen(),
          ],
        ),
      ),
    );
  }
}
