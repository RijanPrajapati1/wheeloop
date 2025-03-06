import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';

// Define the mock class for UsecaseWithParams
class MockUsecaseWithParams<SuccessType, Params> extends Mock
    implements UsecaseWithParams<SuccessType, Params> {}

// Define the mock class for UsecaseWithoutParams
class MockUsecaseWithoutParams<SuccessType> extends Mock
    implements UsecaseWithoutParams<SuccessType> {}

void main() {
  group('UsecaseWithParams', () {
    late MockUsecaseWithParams<String, String> usecaseWithParamsMock;

    setUp(() {
      usecaseWithParamsMock = MockUsecaseWithParams<String, String>();
    });

    test('should return success when called with valid parameters', () async {
      // Arrange: Mock the call to return a successful result
      when(() => usecaseWithParamsMock.call('valid_param'))
          .thenAnswer((_) async => const Right('Success'));

      // Act: Call the use case
      final result = await usecaseWithParamsMock.call('valid_param');

      // Assert: Verify that the result is a success
      expect(result, equals(const Right('Success')));
      verify(() => usecaseWithParamsMock.call('valid_param')).called(1);
    });

    test('should return failure when called with invalid parameters', () async {
      // Arrange: Mock the call to return a failure result
      when(() => usecaseWithParamsMock.call('invalid_param'))
          .thenAnswer((_) async => const Left(ApiFailure(message: '')));

      // Act: Call the use case
      final result = await usecaseWithParamsMock.call('invalid_param');

      // Assert: Verify that the result is a failure
      expect(result, isA<Left>());
      verify(() => usecaseWithParamsMock.call('invalid_param')).called(1);
    });
  });

  group('UsecaseWithoutParams', () {
    late MockUsecaseWithoutParams<String> usecaseWithoutParamsMock;

    setUp(() {
      usecaseWithoutParamsMock = MockUsecaseWithoutParams<String>();
    });

    test('should return success when called without parameters', () async {
      // Arrange: Mock the call to return a successful result
      when(() => usecaseWithoutParamsMock.call())
          .thenAnswer((_) async => const Right('Success'));

      // Act: Call the use case
      final result = await usecaseWithoutParamsMock.call();

      // Assert: Verify that the result is a success
      expect(result, equals(const Right('Success')));
      verify(() => usecaseWithoutParamsMock.call()).called(1);
    });

    test('should return failure when called without parameters and fails',
        () async {
      // Arrange: Mock the call to return a failure result
      when(() => usecaseWithoutParamsMock.call())
          .thenAnswer((_) async => const Left(ApiFailure(message: '')));

      // Act: Call the use case
      final result = await usecaseWithoutParamsMock.call();

      // Assert: Verify that the result is a failure
      expect(result, isA<Left>());
      verify(() => usecaseWithoutParamsMock.call()).called(1);
    });
  });
}
