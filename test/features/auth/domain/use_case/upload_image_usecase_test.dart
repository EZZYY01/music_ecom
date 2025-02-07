import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_ecom/core/error/failure.dart';
import 'package:music_ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:music_ecom/features/auth/domain/use_case/upload_image_usecase.dart';

// Create a fake class for File
class FileFake extends Fake implements File {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    // Register the fallback value for File
    registerFallbackValue(FileFake());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository);
  });

  final tFile = File('test/path/to/file.jpg');
  const tUploadedImageUrl = 'https://example.com/profile.jpg';

  test('should call uploadProfilePicture and return image URL on success',
      () async {
    // Arrange
    when(() => mockAuthRepository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right(tUploadedImageUrl));

    // Act
    final result = await usecase(UploadImageParams(file: tFile));

    // Assert
    expect(result, const Right(tUploadedImageUrl));
    verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when uploadProfilePicture fails', () async {
    // Arrange
    const tFailure = ApiFailure(message: 'Upload failed');
    when(() => mockAuthRepository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(UploadImageParams(file: tFile));

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
