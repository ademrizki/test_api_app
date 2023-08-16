import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_api_app/provider/sign_in_provider.dart';
import 'package:test_api_app/provider/user_provider.dart';
import 'package:test_api_app/views/screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());

  print("nama saya farhan");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MVVM app',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
