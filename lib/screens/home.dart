import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo/photo_bloc.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../widgets/photo_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app_outlined),
        onPressed: () {
          context.read<AuthenticationBloc>().add(SignOutEvent());
        },
      ),
      body: BlocProvider<PhotoBloc>(
        create: (context) => PhotoBloc(),
        child: LayoutBuilder(builder: (context, constraints) {
          return PhotoList(constraints);
        }),
      ),
    );
  }
}
