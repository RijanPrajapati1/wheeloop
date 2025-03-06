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
                              'assets/images/user.jpg'), // Profile image
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Top Brands Section
                  // const SizedBox(height: 10),
                  // const BrandScreen(),

                  // All Cars Section

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
