import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _image;

  // Check for camera permission
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
                    const SizedBox(height: 8),

                    // Profile Image Picker
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  label: const Text('Camera'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  label: const Text('Gallery'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors
                              .transparent, // Make sure background is transparent
                          child: ClipOval(
                            child: Image(
                              image: _image != null
                                  ? FileImage(_image!)
                                  : const AssetImage(
                                          'assets/logos/default_pp.png')
                                      as ImageProvider,
                              fit: BoxFit
                                  .cover, // Ensures image fits inside the circle without distortion
                              width:
                                  100, // Ensures the image takes the full width of the CircleAvatar
                              height:
                                  100, // Ensures the image takes the full height of the CircleAvatar
                            ),
                          ),
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

                    // Address TextField
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
