// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wheeloop/app/service_locator/service_locator.dart';
// import 'package:wheeloop/features/admin/domain/use_case/car_usecase.dart';
// import 'package:wheeloop/features/admin/domain/use_case/upload_car_image.dart';
// import 'package:wheeloop/features/admin/presentation/view_model/admin_car_state.dart';

// class AdminCarCubit extends Cubit<AdminCarState> {
//   final AddCarUseCase _addCarUseCase;
//   final UploadCarImageUseCase _uploadCarImageUseCase;

//   AdminCarCubit(this._addCarUseCase, this._uploadCarImageUseCase)
//       : super(AdminCarState.initial());

//   File? selectedImage; // Store selected image file

//   // Image Upload Event
//   Future<void> uploadImage(File file) async {
//     emit(state.copyWith(isUploadingImage: true));

//     final result = await _uploadCarImageUseCase.call(
//       UploadCarImageParams(file: file),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//             isUploadingImage: false, uploadError: failure.message));
//         ScaffoldMessenger.of(serviceLocator<BuildContext>()).showSnackBar(
//           SnackBar(content: Text('Image upload failed: ${failure.message}')),
//         );
//       },
//       (imageUrl) {
//         emit(state.copyWith(
//           isUploadingImage: false,
//           isSuccess: true,
//           imageUrl: imageUrl,
//         ));
//         selectedImage = file;
//       },
//     );
//   }

//   // Add Car Event
//   Future<void> addCar(AddCarParams params) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _addCarUseCase.call(params);

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//         ScaffoldMessenger.of(serviceLocator<BuildContext>()).showSnackBar(
//           SnackBar(content: Text('Adding car failed: ${failure.message}')),
//         );
//       },
//       (_) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         ScaffoldMessenger.of(serviceLocator<BuildContext>()).showSnackBar(
//           const SnackBar(content: Text('Car added successfully!')),
//         );
//       },
//     );
//   }
// }
