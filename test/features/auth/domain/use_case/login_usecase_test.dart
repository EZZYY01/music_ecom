import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_ecom/core/error/failure.dart';
import 'package:music_ecom/features/auth/domain/use_case/login_usecase.dart';
import 'package:music_ecom/features/auth/domain/use_case/repository.mock.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const tUsername = 'testuser';
  const tPassword = 'password123';
  const tToken = 'mock_token';
  final tParams = LoginParams(username: tUsername, password: tPassword);

  test('should return token when login is successful', () async {
    // Arrange
    when(() => mockAuthRepository.logincustomer(any(), any()))
        .thenAnswer((_) async => const Right(tToken));

    // Act
    final result = await loginUseCase(tParams);

    // Assert
    expect(result, const Right(tToken));
    verify(() => mockAuthRepository.logincustomer(tUsername, tPassword))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when login fails', () async {
    // Arrange
    const tFailure = ApiFailure(message: 'Login failed', statusCode: 401);
    when(() => mockAuthRepository.logincustomer(any(), any()))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await loginUseCase(tParams);

    // Assert
    expect(result, equals(Left(tFailure)));
    verify(() => mockAuthRepository.logincustomer(tUsername, tPassword))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  //  Test: Network Failure During Login
  test('should return network failure when there is a network issue', () async {
    // Arrange
    const tFailure =
        ApiFailure(message: 'No internet connection', statusCode: 503);
    when(() => mockAuthRepository.logincustomer(any(), any()))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await loginUseCase(tParams);

    // Assert
    expect(result, equals(Left(tFailure)));
    verify(() => mockAuthRepository.logincustomer(tUsername, tPassword))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
