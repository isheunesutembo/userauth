import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/repository/localauthrepository.dart';
import 'package:userauth/views/home_screen.dart';
import 'package:userauth/views/log_in_screen.dart';
import 'package:userauth/views/products_screen.dart';
import 'package:userauth/views/register_screen.dart';
Widget _defaultHome=const SignInScreen();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   final container=ProviderContainer();
  final result=await container.read(localAuthRepositoryProvider).isLoggedIn();
  if(result!=null){
    _defaultHome=  HomeScreen();
  }
  runApp(  UncontrolledProviderScope(container: container,child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        '/':(context)=>_defaultHome,
        '/homescreen':(context)=> HomeScreen(),
        '/registerscreen':(context)=>const RegisterScreen(),
        'signinscreen':(context)=>const SignInScreen()
      },
    );
  }
}


