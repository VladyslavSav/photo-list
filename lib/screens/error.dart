import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  AuthBloc _authBloc;

  ErrorScreen(this.message, this._authBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          _authBloc.inputEventSink.add(ProcesEvent());
        },
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
