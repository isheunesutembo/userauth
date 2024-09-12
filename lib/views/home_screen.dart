import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/controllers/usercontroller.dart';
import 'package:userauth/repository/localauthrepository.dart';
import 'package:userauth/uitl/errortext.dart';
import 'package:userauth/uitl/loader.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final localRepository=ref.watch(localAuthRepositoryProvider);
    final userData=ref.watch(getCurrentUser(localRepository.readUserId().toString()));
    return Scaffold(appBar: AppBar(
      title:const Text("Profile",style: TextStyle(color: Colors.black,fontSize: 20),),
      
    ),
    body: userData.when(data: (data){

     return SingleChildScrollView(
      child: Column(children: [
        Text(data.username!),
        Text(data.firstname!),
        Text(data.lastname!),
        ElevatedButton(onPressed: (){
       localRepository.logOut(context);
        }, child:const Text("LogOut"))

      ],),
     );


    }, error: (error,stackTrace)=>ErrorText(error: error.toString(),), loading: ()=>const Loader())
    );
  }
}