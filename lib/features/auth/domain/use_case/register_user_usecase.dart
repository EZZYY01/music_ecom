import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_ecom/app/usecase/usecase.dart';
import 'package:music_ecom/core/error/failure.dart';
import 'package:music_ecom/features/auth/domain/entity/auth_entity.dart';
import 'package:music_ecom/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fName;
  final String lName;
  final String phone;
  final String username;
  final String password;
  final String? profilePhoto;

  const RegisterUserParams({
    required this.fName,
    required this.lName,
    required this.phone,
    required this.username,
    required this.password,
    this.profilePhoto,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fName,
    required this.lName,
    required this.phone,
    required this.username,
    required this.password,
    this.profilePhoto,
  });

  @override
  List<Object?> get props =>
      [fName, lName, phone, username, password, profilePhoto];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fName,
      lName: params.lName,
      phone: params.phone,
      username: params.username,
      password: params.password,
      profilePhoto: params.profilePhoto,
    );
    return repository.registercustomer(authEntity);
  }
}
