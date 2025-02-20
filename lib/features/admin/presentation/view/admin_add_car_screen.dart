import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/admin/domain/use_case/car_usecase.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_car_cubit.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_car_state.dart';

class AdminAddCarScreen extends StatefulWidget {
  const AdminAddCarScreen({super.key});

  @override
  _AdminAddCarScreenState createState() => _AdminAddCarScreenState();
}

class _AdminAddCarScreenState extends State<AdminAddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _transmission = 'Manual';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (mounted) {
        context.read<AdminCarCubit>().uploadImage(_image!);
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<AdminCarCubit>();
      final imageUrl = cubit.state.imageUrl ?? '';

      final carParams = AddCarParams(
        name: _nameController.text,
        brand: _brandController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        transmission: _transmission,
        image: imageUrl,
      );

      cubit.addCar(carParams);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<AdminCarCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Car"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: BlocBuilder<AdminCarCubit, AdminCarState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text("Camera"),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Gallery"),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          child: _image != null
                              ? ClipOval(
                                  child: Image.file(_image!,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100))
                              : const Icon(Icons.camera_alt, size: 50),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(_nameController, "Car Name"),
                      _buildTextField(_brandController, "Car Brand"),
                      _buildTextField(_priceController, "Price"),
                      _buildTextField(_descriptionController, "Description",
                          maxLines: 3),
                      DropdownButtonFormField<String>(
                        value: _transmission,
                        items: ["Manual", "Automatic"].map((String category) {
                          return DropdownMenuItem<String>(
                              value: category, child: Text(category));
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _transmission = value!),
                        decoration: const InputDecoration(
                            hintText: "Select Transmission"),
                      ),
                      state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text("Add Car")),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(labelText: label)),
    );
  }
}
