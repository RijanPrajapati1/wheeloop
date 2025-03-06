import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';
import 'package:wheeloop/features/payment/presentation/view/payment.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const BookingScreen({super.key, required this.car});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController pickUpController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController driverDaysController = TextEditingController();

  bool isLoading = false;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> handleBooking() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final bookingData = {
        "name": nameController.text,
        "contact": contactController.text,
        "pickUpLocation": pickUpController.text,
        "startDate": startDateController.text,
        "endDate": endDateController.text,
        "driverDays": int.tryParse(driverDaysController.text) ?? 0,

        "status": "pending", //  Automatically setting status to "pending"
      };

      final response = await _dio.post(ApiEndpoints.bookCar, data: bookingData);

      if (response.statusCode == 201) {
        showSnackbar("Booking Created. Proceed to Payment!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentScreen(),
          ),
        );
      } else {
        showSnackbar("Booking Failed. Try again!");
      }
    } catch (e) {
      showSnackbar("Error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      appBar: AppBar(title: const Text("Book Car")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  car['image']!.replaceFirst("localhost", "192.168.16.211"),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(car['name'],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text("Rs. ${car['price']}/day",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              const SizedBox(height: 20),
              const Text("Booking Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your name" : null),
              TextFormField(
                  controller: contactController,
                  decoration:
                      const InputDecoration(labelText: "Contact Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Enter contact number" : null),
              TextFormField(
                  controller: pickUpController,
                  decoration:
                      const InputDecoration(labelText: "Pick-Up Location"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter pick-up location" : null),
              TextFormField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                      labelText: "Start Date (YYYY-MM-DD)"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter start date" : null),
              TextFormField(
                  controller: endDateController,
                  decoration:
                      const InputDecoration(labelText: "End Date (YYYY-MM-DD)"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter end date" : null),
              TextFormField(
                  controller: driverDaysController,
                  decoration: const InputDecoration(
                      labelText: "Driver Days (Rs.500/day)"),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? "Enter driver days" : null),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : handleBooking,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Proceed to Payment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
