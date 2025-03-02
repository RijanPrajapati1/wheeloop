// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wheeloop/app/usecase/usecase.dart';
// import 'package:wheeloop/core/error/failure.dart';
// import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';
// import 'package:wheeloop/features/admin/domain/repository/car_repository.dart';

// class AddCarParams extends Equatable {
//   final String name;
//   final String brand;
//   final String price;
//   final String description;
//   final String transmission;
//   final String image;

//   const AddCarParams({
//     required this.name,
//     required this.brand,
//     required this.price,
//     required this.description,
//     required this.transmission,
//     required this.image,
//   });

//   // Initial Constructor
//   const AddCarParams.initial({
//     required this.name,
//     required this.brand,
//     required this.price,
//     required this.description,
//     required this.transmission,
//     required this.image,
//   });

//   // Empty Constructor for Initialization
//   const AddCarParams.empty()
//       : name = '_empty.name',
//         brand = '_empty.brand',
//         price = '_empty.price',
//         description = '_empty.description',
//         transmission = '_empty.transmission',
//         image = '_empty.image';

//   @override
//   List<Object?> get props =>
//       [name, brand, price, description, transmission, image];
// }

// class AddCarUseCase implements UsecaseWithParams<void, AddCarParams> {
//   final ICarRepository repository;

//   AddCarUseCase(this.repository);

//   @override
//   Future<Either<Failure, void>> call(AddCarParams params) {
//     final carEntity = CarEntity(
//       name: params.name,
//       type: params.brand, // Replacing type with brand
//       price: params.price,
//       description: params.description,
//       transmission: params.transmission,
//       image: params.image,
//     );
//     return repository.addCar(carEntity);
//   }
// }
