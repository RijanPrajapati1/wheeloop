import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: BlocBuilder<SignUpScreenCubit, SignUpState>(
            builder: (context, state) {
              final cubit = context.read<SignUpScreenCubit>();

              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 3),
                    const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.deepPurple,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Fill in the details to create an account",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/logos/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Full Name TextField
                    TextFormField(
                      controller: cubit.nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['name'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 15),
                    // Phone Number TextField
                    TextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['phone'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 15),
                    // Email TextField
                    TextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['email'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 15),
                    //address
                    TextFormField(
                      controller: cubit.addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['address'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 15),
                    // Password TextField
                    TextFormField(
                      controller: cubit.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['password'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 15),
                    // Confirm Password TextField
                    TextFormField(
                      controller: cubit.confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: state.validationErrors['confirmPassword'],
                      ),
                      onChanged: (_) {
                        cubit.validateForm();
                      },
                    ),
                    const SizedBox(height: 20),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              cubit.signUp(context); // Call signUp method
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 10),
                    // Login Navigation Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style:
                              TextStyle(color: Colors.black, letterSpacing: 1),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<SignUpScreenCubit>()
                                .navigateToLogin(context);
                          },
                          child: const Text(
                            "Login",
                            style:
                                TextStyle(color: Colors.blue, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
