import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';
import 'package:wheeloop/features/auth/domain/use_case/upload_image_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UploadImageUsecase(repository);
    registerFallbackValue(File('')); // Fallback value for File type in mocktail
  });

  test(
      'should call the [AuthRepository.uploadProfilePicture] and return image URL',
      () async {
    // Arrange
    final params =
        UploadImageParams(file: File('test_image.jpg')); // Mock file path
    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right('image_url'));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right('image_url'));

    // Verify method call
    verify(() => repository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure when upload fails', () async {
    // Arrange
    final params = UploadImageParams(file: File('test_image.jpg'));
    when(() => repository.uploadProfilePicture(any())).thenAnswer((_) async =>
        const Left(ApiFailure(
            message: 'Upload failed'))); // Using ApiFailure with a message

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, isA<Left<Failure, String>>()); // Expect failure

    // Verify method call
    verify(() => repository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should handle empty file scenario gracefully', () async {
    // Arrange
    final params = UploadImageParams.empty(); // Using empty constructor
    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right('default_image_url'));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right('default_image_url'));

    // Verify method call
    verify(() => repository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
