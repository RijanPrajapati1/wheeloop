import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/car/presentation/view/car_screen.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Location Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.black),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your location",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              state
                                  .location, // Display the location from the cubit state
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 26,
                          backgroundImage: AssetImage(
                              'assets/images/car_splash.png'), // Profile image
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
                            onChanged: (value) {
                              context.read<HomeCubit>().updateSearchText(
                                  value); // Update search text in cubit
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search Your Favorite Vehicle",
                              filled: true,
                              fillColor: Colors.grey[120],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              labelText: state.searchText.isEmpty
                                  ? "Search Your Favorite Vehicle"
                                  : state.searchText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            // Implement filtering logic if needed
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Top Brands Section
                  // const SizedBox(height: 10),
                  // const BrandScreen(),
                  const SizedBox(height: 20),
                  // All Cars Section
                  const SizedBox(height: 10),
                  const CarScreen(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
