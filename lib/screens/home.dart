import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../widgets/photo_list.dart';

class HomeScreen extends StatelessWidget {
  final AuthBloc _authBloc;
  HomeScreen(this._authBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app_outlined),
        onPressed: () {
          _authBloc.inputEventSink.add(SignOutEvent());
        },
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return PhotoList(constraints);
      }),
    );
  }
}
