import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_ecom/app/usecase/usecase.dart';
import 'package:music_ecom/core/error/failure.dart';
import 'package:music_ecom/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.logincustomer(params.username, params.password);
  }
}
