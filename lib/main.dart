import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/error.dart';

import './bloc/auth_bloc.dart';
import './bloc/auth_event.dart';
import './bloc/auth_state.dart';
import './screens/home.dart';
import './screens/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    _authBloc.inputEventSink.add(ProcesEvent());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<AuthState>(
        stream: _authBloc.outputStateStream,
        initialData: AuthState.Proces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == AuthState.SignOuted)
              return SignInScreen(_authBloc);
            else if (snapshot.data == AuthState.SignIned)
              return HomeScreen(_authBloc);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ErrorScreen(snapshot.error.toString(), _authBloc);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }
}
