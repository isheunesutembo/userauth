import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:userauth/config/appconfig.dart';
import 'package:userauth/models/usermodel.dart';
import 'package:userauth/providers/providers.dart';
import 'package:userauth/repository/localauthrepository.dart';
import 'package:userauth/utils/appfailure.dart';

final authRepositoryProvider=Provider((ref)=>AuthRepository(client: ref.watch(httpProvider),localauthrepository: ref.watch(localAuthRepositoryProvider)));
class AuthRepository{
  final http.Client _client;
  final LocalAuthRepository _localAuthRepository;
  AuthRepository({required  http.Client client,required LocalAuthRepository localauthrepository}):_client=client,_localAuthRepository=localauthrepository;
   Future<Either<AppFailure, UserModel>> logInWithEmailPassword(
      String email, String password) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Appconfig.baseUrl, Appconfig.logInUrl);
    var response = await _client.post(url,
        headers: requestHeaders,
        body: jsonEncode({"email": email, "password": password}));
    var data = jsonDecode(response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _localAuthRepository.storeToken(data['_id']);
        _localAuthRepository.storeToken(data["userToken"]);
        return Right(UserModel.fromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
    Future<Either<AppFailure, UserModel>> registerWithEmailPassword(
      String email, String username, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Appconfig.baseUrl, Appconfig.registerUrl);
    var response = await _client.post(url,
        headers: requestHeaders,
        body: jsonEncode(
            {"email": email, "username": username, "password": password}));
    var data = jsonDecode(response.body);
    try {
  
      if (response.statusCode == 200 || response == 201) {
        return Right(UserModel.fromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

 /* Future<Either<AppFailure, UserModel>> getCurrentUserData(
      String userId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ${_localAuthRepository.isLoggedIn()}'
      
    };
    var url = Uri.http(Appconfig.baseUrl, "${Appconfig.usersUrl}/$userId");
    var response = await _client.get(url,headers: requestHeaders);
    var data = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        return Right(data);
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: data["message"]));
    }
  }
  */
}