// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class CarScreen extends StatefulWidget {
//   const CarScreen({super.key});

//   @override
//   State<CarScreen> createState() => _CarScreenState();
// }

// class _CarScreenState extends State<CarScreen> {
//   final List<Map<String, dynamic>> cars = const [
//     {
//       'name': 'Range Rover Evo',
//       'type': 'sports',
//       'price': 'Rs. 500/day',
//       'rating': 4.5,
//       'transmission': 'manual',
//       'details': 'this is the car of century',
//       'image': 'assets/images/rangerover_car.png',
//     },
//     {
//       'name': 'Mercedes-Benz ML 400',
//       'type': 'luxury',
//       'price': 'Rs. 700/day',
//       'rating': 4.0,
//       'transmission': 'automatic',
//       'details': 'luxurious and comfortable',
//       'image': 'assets/images/merce-cr.png',
//     },
//     {
//       'name': 'Audi Q5',
//       'type': 'SUV',
//       'price': 'Rs. 450/day',
//       'rating': 4.7,
//       'transmission': 'manual',
//       'details': 'perfect for long drives',
//       'image': 'assets/images/car_image_1.png',
//     },
//     {
//       'name': 'BMW X5',
//       'type': 'luxury',
//       'price': 'Rs. 600/day',
//       'rating': 4.8,
//       'transmission': 'automatic',
//       'details': 'comfort meets performance',
//       'image': 'assets/images/bmw_car.png',
//     },
//     {
//       'name': 'Tesla Model X',
//       'type': 'electric',
//       'price': 'Rs. 750/day',
//       'rating': 4.9,
//       'transmission': 'automatic',
//       'details': 'the future of driving',
//       'image': 'assets/images/tesla_car.png',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // All Cars Section
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "All Cars",
//                   style: TextStyle(fontSize: 16, fontFamily: 'Montserrat Bold'),
//                 ),
//                 Text(
//                   "View All",
//                   style: TextStyle(fontSize: 14, color: Colors.blue),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 280,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: cars.length,
//               itemBuilder: (context, index) {
//                 final car = cars[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to Car Detail Screen on tap
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CarDetailScreen(car: car),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                     child: Container(
//                       width: 200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(16),
//                             ),
//                             child: Image.asset(
//                               car['image']!,
//                               height: 160,
//                               width: double.infinity,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   car['name']!,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 RatingBarIndicator(
//                                   rating: car['rating']!,
//                                   itemBuilder: (context, _) => const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                   ),
//                                   itemCount: 5,
//                                   itemSize: 18,
//                                   direction: Axis.horizontal,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   car['price']!,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Static Best-Selling Car Section
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               "Best-Selling Car",
//               style: TextStyle(fontSize: 16, fontFamily: 'Montserrat Bold'),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.asset(
//                       'assets/images/maruti_car.png', // Static image
//                       height: 160,
//                       width: double.infinity,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Maruti Suzuki Swift", // Static name
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         RatingBarIndicator(
//                           rating: 4.9, // Static rating
//                           itemBuilder: (context, _) => const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                           itemCount: 5,
//                           itemSize: 18,
//                           direction: Axis.horizontal,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           "Rs. 400/day", // Static price
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CarDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> car;

//   const CarDetailScreen({super.key, required this.car});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(car['name']!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               car['image']!,
//               height: 250,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               car['name']!,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             RatingBarIndicator(
//               rating: car['rating']!,
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               itemCount: 5,
//               itemSize: 18,
//               direction: Axis.horizontal,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               car['price']!,
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Type: ${car['type']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Transmission: ${car['transmission']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Details: ${car['details']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 // Booking logic here
//                 // You can navigate to booking screen or show a dialog
//               },
//               child: const Text('Book Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
