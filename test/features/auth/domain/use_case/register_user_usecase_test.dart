import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_ecom/core/error/failure.dart';
import 'package:music_ecom/features/auth/domain/entity/auth_entity.dart';
import 'package:music_ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:music_ecom/features/auth/domain/use_case/register_user_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const tParams = RegisterUserParams(
    fName: 'Manish',
    lName: 'Shrestha',
    phone: '1234567890',
    username: 'mmm',
    password: 'mmm111',
    profilePhoto: null,
  );

  final tAuthEntity = AuthEntity(
    fName: tParams.fName,
    lName: tParams.lName,
    phone: tParams.phone,
    username: tParams.username,
    password: tParams.password,
    profilePhoto: tParams.profilePhoto,
  );

  test('should call registercustomer on repository with correct parameters',
      () async {
    // Arrange
    when(() => mockAuthRepository.registercustomer(tAuthEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, equals(const Right(null)));
    verify(() => mockAuthRepository.registercustomer(tAuthEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    const tFailure = ApiFailure(message: 'Registration Failed');
    when(() => mockAuthRepository.registercustomer(tAuthEntity))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, equals(const Left(tFailure)));
    verify(() => mockAuthRepository.registercustomer(tAuthEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
