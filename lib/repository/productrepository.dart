import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:userauth/config/appconfig.dart';
import 'package:userauth/models/productfiltermodel.dart';
import 'package:userauth/models/productmodel.dart';
import 'package:userauth/providers/providers.dart';
import 'package:userauth/utils/appfailure.dart';

final productsRepositoryProvider =
    Provider((ref) => ProductRepository(client: ref.watch(httpProvider)));

class ProductRepository {
  final http.Client _client;
  ProductRepository({required http.Client client}) : _client = client;

  Future<Either<AppFailure, ProductModel>> createProduct(
      File image,
      String title,
      String description,
      double price,
      double oldPrice,
     ) async {
    var url = Uri.http(Appconfig.baseUrl, Appconfig.productsUrl);
    var request = http.MultipartRequest('POST', Uri.parse(url.toString()));
    request.files.add(await http.MultipartFile.fromPath("image", image.path));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['oldPrice'] = oldPrice.toString();
   

    try {
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(ProductModel.fromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, List<ProductModel>>> getProducts() async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
   

    
    
    var url = Uri.http(Appconfig.baseUrl, Appconfig.productsUrl);
    var response = await _client.get(url, headers: requestHeaders);
    var data = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        return Right(productsFromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, ProductModel>> updateProduct(
      File image,
      String title,
      String description,
      double price,
      double oldPrice,
      String productId) async {
    var url = Uri.http(
        Appconfig.baseUrl, "${Appconfig.productsUrl + "/" + productId}");
    var request = http.MultipartRequest('PUT', Uri.parse(url.toString()));
    request.files.add(await http.MultipartFile.fromPath("image", image.path));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['oldPrice'] = oldPrice.toString();
    

    try {
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(ProductModel.fromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, List<ProductModel>>> deleteProducts(
      String productId) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    var url =
        Uri.http(Appconfig.baseUrl, '${Appconfig.productsUrl}/$productId');
    var response = await _client.delete(url, headers: requestHeaders);
    var data = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        return Right(productsFromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, List<ProductModel>>> getProductById(
      String productId) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    var url =
        Uri.http(Appconfig.baseUrl, '${Appconfig.productsUrl}/$productId');
    var response = await _client.get(url, headers: requestHeaders);
    var data = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        return Right(productsFromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
