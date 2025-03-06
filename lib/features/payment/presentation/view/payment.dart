// payment_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/payment/presentation/view_model/payment_cubit.dart';
import 'package:wheeloop/features/payment/presentation/view_model/payment_state.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Dio _dio = Dio();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool isLoading = false;
  String selectedPaymentOption = 'Credit Card'; // Default option

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(_dio),
      child: Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Details Section
              const Text(
                "Car Name: Tesla X",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Car Price: Rs. 4500 per day",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                "Driver: 1 day",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                "Days: 3",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                "Total Amount: Rs. 14000",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text("Payment Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              // Payment Option selection
              const Text("Select Payment Option:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: const Text("Credit Card"),
                value: 'Credit Card',
                groupValue: selectedPaymentOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text("PayPal"),
                value: 'PayPal',
                groupValue: selectedPaymentOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text("Cash on Delivery"),
                value: 'Cash on Delivery',
                groupValue: selectedPaymentOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Conditional Fields for Credit/Debit Card
              if (selectedPaymentOption == 'Credit Card' ||
                  selectedPaymentOption == 'Debit Card') ...[
                TextField(
                  controller: cardHolderController,
                  decoration:
                      const InputDecoration(labelText: "Card Holder Name"),
                ),
                TextField(
                  controller: cardNumberController,
                  decoration: const InputDecoration(labelText: "Card Number"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: expiryDateController,
                  decoration:
                      const InputDecoration(labelText: "Expiry Date (MM/YY)"),
                ),
                TextField(
                  controller: cvvController,
                  decoration: const InputDecoration(labelText: "CVV"),
                  keyboardType: TextInputType.number,
                ),
              ],
              // No fields for PayPal or Cash on Delivery
              if (selectedPaymentOption == 'PayPal') ...[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Transaction Pin",
                    hintText: "Enter transaction pin",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],

              if (selectedPaymentOption == 'Cash on Delivery') ...[
                const Text("You will pay in cash upon receiving the vehicle."),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPaymentOption == 'Credit Card' ||
                        selectedPaymentOption == 'Debit Card') {
                      if (cardHolderController.text.isEmpty ||
                          cardNumberController.text.isEmpty ||
                          expiryDateController.text.isEmpty ||
                          cvvController.text.isEmpty) {
                        showSnackbar("Please fill all card details.");
                        return;
                      }
                    }

                    // Prepare payment data
                    final paymentData = {
                      "paymentOption": selectedPaymentOption,
                      "cardHolder": cardHolderController.text,
                      "cardNumber": cardNumberController.text,
                      "expiryDate": expiryDateController.text,
                      "cvv": cvvController.text,
                    };

                    // Trigger payment using Cubit
                    context.read<PaymentCubit>().processPayment(paymentData);
                  },
                  child: BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                      if (state is PaymentLoading) {
                        return const CircularProgressIndicator();
                      }
                      return const Text("Confirm Payment");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
