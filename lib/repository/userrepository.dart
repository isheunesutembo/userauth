import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:userauth/models/usermodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/providers/providers.dart';
import 'package:userauth/repository/localauthrepository.dart';
import 'package:userauth/utils/appfailure.dart';
import 'package:userauth/config/appconfig.dart';
final userRepositoryProvider=Provider((ref)=>UserRepository(client: ref.watch(httpProvider), localauthrepository: ref.watch(localAuthRepositoryProvider)));
class UserRepository{
  final http.Client _client;
  final LocalAuthRepository _localAuthRepository;

  UserRepository({required http.Client client,
  required LocalAuthRepository localauthrepository}):_client=client,_localAuthRepository=localauthrepository;
    Future< Either<AppFailure,UserModel>> getCurrentUser(String userId) async {
    Map<String, String> requestHeaders = {
    
     // "Authorization":"Bearer ${_localAuthRepository.isLoggedIn()}"
    };
    var url = Uri.http(Appconfig.baseUrl, "${Appconfig.userUrl}/$userId");
    var response = await _client.get(url, headers: requestHeaders);
    var data = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(data));
      } else {
        return Left(AppFailure(message: data['message']));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}