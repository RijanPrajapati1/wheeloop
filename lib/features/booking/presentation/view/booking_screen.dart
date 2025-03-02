import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const BookingScreen({super.key, required this.car});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isBookingConfirmed = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController pickUpController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController driverDaysController = TextEditingController();

  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Function to process booking and payment
  Future<void> processBookingAndPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      const userId = "12345"; // Replace with actual user ID from auth
      final rentalDays =
          calculateDays(startDateController.text, endDateController.text);
      final driverCost = int.parse(driverDaysController.text) * 500;
      final totalAmount = rentalDays * widget.car['price'] + driverCost;

      final bookingData = {
        "userId": userId,
        "carId": widget.car['id'],
        "name": nameController.text,
        "contact": contactController.text,
        "pickUpLocation": pickUpController.text,
        "startDate": startDateController.text,
        "endDate": endDateController.text,
        "driverDays": int.parse(driverDaysController.text),
        "totalAmount": totalAmount,
        "status": "pending",
        "payment": {
          "cardHolder": cardHolderController.text,
          "cardNumber": cardNumberController.text,
          "expiryDate": expiryDateController.text,
        }
      };

      final response = await _dio.post(
          "http://10.0.2.2:3001/api/rental/processPayment",
          data: bookingData);

      if (response.statusCode == 201) {
        setState(() {
          isBookingConfirmed = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Payment successful! Booking confirmed.")),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        throw Exception("Payment failed! Please try again.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to process booking. $e")),
      );
    }

    setState(() => isLoading = false);
  }

  int calculateDays(String start, String end) {
    final startDate = DateTime.parse(start);
    final endDate = DateTime.parse(end);
    return endDate.difference(startDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      appBar: AppBar(title: const Text("Book & Pay")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Car Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  car['image']!.replaceFirst("localhost", "10.0.2.2"),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Car Name & Price
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

              // ✅ Booking Form
              const Text("Booking Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Enter contact number" : null,
              ),
              TextFormField(
                controller: pickUpController,
                decoration:
                    const InputDecoration(labelText: "Pick-Up Location"),
                validator: (value) =>
                    value!.isEmpty ? "Enter pick-up location" : null,
              ),
              TextFormField(
                controller: startDateController,
                decoration:
                    const InputDecoration(labelText: "Start Date (YYYY-MM-DD)"),
                validator: (value) =>
                    value!.isEmpty ? "Enter start date" : null,
              ),
              TextFormField(
                controller: endDateController,
                decoration:
                    const InputDecoration(labelText: "End Date (YYYY-MM-DD)"),
                validator: (value) => value!.isEmpty ? "Enter end date" : null,
              ),
              TextFormField(
                controller: driverDaysController,
                decoration: const InputDecoration(
                    labelText: "Driver Days (Rs.500/day)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Enter driver days" : null,
              ),

              const SizedBox(height: 24),

              // ✅ Payment Form
              const Text("Payment Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              TextFormField(
                controller: cardHolderController,
                decoration:
                    const InputDecoration(labelText: "Card Holder Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter card holder name" : null,
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: "Card Number"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Enter card number" : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: expiryDateController,
                      decoration: const InputDecoration(
                          labelText: "Expiry Date (MM/YY)"),
                      validator: (value) =>
                          value!.isEmpty ? "Enter expiry date" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: cvvController,
                      decoration: const InputDecoration(labelText: "CVV"),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? "Enter CVV" : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ✅ Pay & Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : processBookingAndPayment,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Pay & Confirm Booking"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
