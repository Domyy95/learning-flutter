import 'package:bloc_pattern/screens/forgot_password.dart';
import 'package:bloc_pattern/screens/home.dart';
import 'package:bloc_pattern/screens/login.dart';
import 'package:bloc_pattern/screens/signup.dart';

import 'app_routes.dart';
import 'cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: AppRoutes.login,
        routes: <String, WidgetBuilder>{
          AppRoutes.login: (_) => const login(),
          AppRoutes.signup: (_) => const signup(),
          AppRoutes.forgotPassword: (_) => forgotPassword(),
          AppRoutes.home: (_) => const home(),
        },
      ),
    );
  }
}