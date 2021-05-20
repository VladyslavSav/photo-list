import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/authentication/authentication_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/authentication/authentication_state.dart';
import './screens/home.dart';
import './screens/sign_in.dart';
import './bloc/authentication/authentication_bloc.dart';

void main() {
  Bloc.observer = BlocObserver();
  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //BlocProvider<AuthenticationBloc>(

          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              bloc: context.read<AuthenticationBloc>(),
              builder: (context, state) {
                if (state is SignOuted) {
                  return SignInScreen();
                } else if (state is SignIned) {
                  return HomeScreen();
                } else if (state is UnInitialized) {
                  context.read<AuthenticationBloc>().add(InitializingEvent());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
    );
  }
}
