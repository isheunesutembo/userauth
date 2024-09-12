
import 'package:fpdart/fpdart.dart';
import 'package:userauth/models/usermodel.dart';
import 'package:userauth/repository/userrepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final userControllerProvider=AsyncNotifierProvider<UserController,AsyncValue<UserModel>>(UserController.new);

final getCurrentUser=FutureProvider.family((ref,String userId){
final userController=ref.watch(userControllerProvider.notifier)
.getCurrentUser(userId);
return userController;
});
class UserController extends AsyncNotifier<AsyncValue<UserModel>>{
  late UserRepository _userRepository;
  AsyncValue<UserModel>build(){
    _userRepository=ref.watch(userRepositoryProvider);
  return null!;
  }
  Future<UserModel>getCurrentUser(String userId)async{
   final res= await _userRepository.getCurrentUser(userId);

   return switch(res){
    Left(value:final l)=>throw l.message,
    Right(value:final r)=>r
   };
    

  }
}