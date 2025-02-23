import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_fetching_car_cubit.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_fetching_car_state.dart';

class AdminFetchCarScreen extends StatefulWidget {
  const AdminFetchCarScreen({super.key});

  @override
  _AdminFetchCarScreenState createState() => _AdminFetchCarScreenState();
}

class _AdminFetchCarScreenState extends State<AdminFetchCarScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AdminFetchCarCubit>()
        .fetchCars(); // ✅ Fetch cars when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<AdminFetchCarCubit>()..fetchCars(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Cars"),
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<AdminFetchCarCubit, AdminFetchCarState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Text(
                  "Error: ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.cars.isEmpty) {
              return const Center(child: Text("No cars found."));
            }

            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                final car = state.cars[index];

                // ✅ Ensure Correct Image Path
                String imageUrl = (car.image.isNotEmpty)
                    ? "http://10.0.2.2:3001${car.image}" // ✅ Uses correct API image path
                    : "http://10.0.2.2:3001/uploads/default_car.png"; // ✅ Placeholder if no image

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.car_rental,
                          size: 50,
                          color: Colors.grey), // ✅ Placeholder if image fails
                    ),
                    title: Text(car.name),
                    subtitle: Text("Price: ${car.price}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Implement delete logic
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
