import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';
import 'package:wheeloop/features/auth/domain/use_case/register_usecase.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepoMock repository;
  late RegisterUseCase usecase;

  setUp(() {
    repository = AuthRepoMock();
    usecase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity.empty());
  });

  const params = RegisterUserParams.empty();

  test('should call the [AuthRepository.register]', () async {
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Right(null),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));

    // Verify
    verify(() => repository.registerUser(any())).called(1);

    verifyNoMoreInteractions(repository);
  });
}
