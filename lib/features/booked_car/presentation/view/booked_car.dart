// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wheeloop/features/booked_car/presentation/view_model/booked_car_cubit.dart';
// import 'package:wheeloop/features/booked_car/presentation/view_model/booked_car_state.dart';

// class BookedScreen extends StatelessWidget {
//   const BookedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BookedCarCubit(Dio())..fetchBookings(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Manage Bookings")),
//         body: BlocBuilder<BookedCarCubit, BookedCarState>(
//           builder: (context, state) {
//             if (state is BookingLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is BookingLoaded) {
//               if (state.bookings.isEmpty) {
//                 return const Center(child: Text('No Bookings available.'));
//               }
//               return ListView.builder(
//                 itemCount: state.bookings.length,
//                 itemBuilder: (context, index) {
//                   final booking = state.bookings[index];

//                   // Check if 'car' and 'user' exist and are maps before accessing properties
//                   final car = (booking['car'] is Map) ? booking['car'] : null;
//                   final user =
//                       (booking['user'] is Map) ? booking['user'] : null;

//                   return ListTile(
//                     title: Text(
//                       car?['model']?.toString() ?? 'Unknown Car',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Booked by: ${user?['name']?.toString() ?? 'Unknown'}',
//                     ),
//                     trailing: booking['status'] == 'pending'
//                         ? const Icon(Icons.pending, color: Colors.orange)
//                         : const Icon(Icons.check_circle, color: Colors.green),
//                   );
//                 },
//               );
//             } else if (state is BookingError) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text('No data available.'));
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static bookings data
    final List<Map<String, dynamic>> bookings = [
      {
        "bookingId": "B001",
        "userId": "U123",
        "user": {"name": "Rijan Prajapati"},
        "car": {"model": "Tesla Model 3"},
        "start_date": "2025-03-05",
        "end_date": "2025-03-09",
        "driver": "1",
        "total": 20000,
        "status": "pending",
      },
    ];

    return Scaffold(
      body: bookings.isEmpty
          ? const Center(child: Text('No Bookings available.'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text(
                    booking['car']?['model']?.toString() ?? 'Unknown Car',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Booked by: ${booking['user']?['name']?.toString() ?? 'Unknown'}\n'
                      'Start-Date: ${booking['start_date']}\n'
                      'End-Date: ${booking['end_date']}\n'
                      'End-Date: ${booking['end_date']}\n'
                      'Driver: ${booking['driver']} \n'
                      'Status: ${booking['status']}\n'),
                  trailing: booking['status'] == 'pending'
                      ? const Icon(Icons.pending, color: Colors.orange)
                      : const Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
    );
  }
}
