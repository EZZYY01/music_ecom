import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';
import '../../models/product/product_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductResponseModel> getProducts(params) async {
    // Construct the URL
    final String url = '$baseUrl/products';
    
    // Debug: print the URL being used
    print("Request URL: $url");

    // Call the function to fetch data from the URL
    return await _getProductFromUrl(url);
  }

  Future<ProductResponseModel> _getProductFromUrl(String url) async {
    // Send the GET request to the provided URL
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Debug: Print the response status and body
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // If the response is successful, parse the JSON into the model
      return productResponseModelFromJson(response.body);
    } else {
      // If there's an error, throw a ServerException
      throw ServerException();
    }
  }
}
