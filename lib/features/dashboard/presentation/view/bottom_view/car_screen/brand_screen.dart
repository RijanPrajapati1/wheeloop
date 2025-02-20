// import 'package:flutter/material.dart';

// class BrandScreen extends StatefulWidget {
//   const BrandScreen({super.key});

//   @override
//   State<BrandScreen> createState() => _BrandScreenState();
// }

// class _BrandScreenState extends State<BrandScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Top Brands",
//                 style: TextStyle(fontSize: 16, fontFamily: 'Montserrat Bold'),
//               ),
//               Text(
//                 "View All",
//                 style: TextStyle(fontSize: 14, color: Colors.blue),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 100,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: const [
//               BrandIcon(name: "BMW", asset: 'assets/logos/bmw_logo.png'),
//               BrandIcon(name: "Mercedes", asset: 'assets/logos/merce-logo.png'),
//               BrandIcon(
//                   name: "Porsche", asset: 'assets/logos/porsche_logo.png'),
//               BrandIcon(name: "Maruti", asset: 'assets/logos/maruti_logo.png'),
//               BrandIcon(name: "Lambo", asset: 'assets/logos/lambo_logo.png'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BrandIcon extends StatefulWidget {
//   final String name;
//   final String asset;

//   const BrandIcon({super.key, required this.name, required this.asset});

//   @override
//   State<BrandIcon> createState() => _BrandIconState();
// }

// class _BrandIconState extends State<BrandIcon> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 31,
//             backgroundImage: AssetImage(widget.asset),
//             backgroundColor: Colors.white,
//           ),
//           const SizedBox(height: 5),
//           Text(widget.name),
//         ],
//       ),
//     );
//   }
// }
