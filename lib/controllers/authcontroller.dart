import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:userauth/models/usermodel.dart';
import 'package:userauth/repository/authrepository.dart';
import 'package:userauth/repository/localauthrepository.dart';
import 'package:userauth/utils/utils.dart';



final authControllerProvider=AsyncNotifierProvider<AuthContoller,AsyncValue<void>>(AuthContoller.new);
class AuthContoller extends AsyncNotifier<AsyncValue<void>>{
 late AuthRepository _authRepository;
 late LocalAuthRepository _localAuthRepository;

@override
 AsyncValue<void> build(){
  _authRepository=ref.watch(authRepositoryProvider);
  _localAuthRepository=ref.watch(localAuthRepositoryProvider);
  
  return AsyncValue.data(null);
 }

 Future<void> logInWithEmailPassword(String email,String password,BuildContext context)async{
 final user=await _authRepository.logInWithEmailPassword(email, password);
  final val= switch(user){
    Left(value:final l)=> showSnackBar(context,l.toString()),
    Right(value:final r

     )=>Navigator.pushNamed(context, "/homescreen")
  };   
 }

  Future<void>registerWithEmailPassword(String email,String username,String password,BuildContext context)async{
  final user=await _authRepository.registerWithEmailPassword(email, username, password);

  final val=switch(user){
    Left(value: final l)=>showSnackBar(context,l.toString()),
      Right(value:final r)=>Navigator.pushNamed(context, "/loginscreen")
    
  };

 }
/*
 Future<UserModel?>getCurrentUserData()async{
  state= const AsyncValue.loading();
  final userId=_localAuthRepository.readUserId();
  if(userId!= null){
    final res=await _authRepository.getCurrentUserData(userId.toString());
    final val=switch(res){
      Left(value:final l)=>state=AsyncValue.error(l.message, StackTrace.current),
      Right(value:final r)=>_getDataSuccess(r)
    };
    return val.value;
  }
  return null;
 }

 AsyncValue<UserModel>_getDataSuccess(UserModel user){
  _currentUserNotifier.addUser(user);
  return state=AsyncValue.data(user);
 }
 */

}
