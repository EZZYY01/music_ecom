import 'package:flutter_test/flutter_test.dart';
import 'package:music_ecom/features/auth/data/model/auth_api_model.dart';
import 'package:music_ecom/features/auth/domain/entity/auth_entity.dart';

void main() {
  const tAuthApiModel = AuthApiModel(
    userId: '123',
    fName: 'Manish',
    lName: 'Shrestha',
    image: 'profile.jpg',
    phone: '1234567890',
    username: 'mm',
    password: 'mmm111',
  );

  const tAuthEntity = AuthEntity(
    userId: '',
    fName: 'Manish',
    lName: 'Shrestha',
    image: 'profile.jpg',
    phone: '1234567890',
    username: 'mm',
    password: 'mmm111',
  );

  final tJson = {
    '_id': '123',
    'fName': 'Manish',
    'lName': 'Shrestha',
    'image': 'profile.jpg',
    'phone': '1234567890',
    'username': 'mm',
    'password': 'mmm111',
  };

  test('should correctly convert from JSON', () {
    final result = AuthApiModel.fromJson(tJson);
    expect(result, tAuthApiModel);
  });

  test('should correctly convert to JSON', () {
    final result = tAuthApiModel.toJson();
    expect(result, tJson);
  });

  test('should correctly convert to Entity', () {
    final result = tAuthApiModel.toEntity();
    expect(result, tAuthEntity);
  });
}
