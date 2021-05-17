import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  final AuthBloc _authBloc;

  SignInScreen(this._authBloc);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Container(
              width: screenSize.width * 0.8,
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: screenSize.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Center(
              child: SignInForm(_authBloc),
            ),
          ],
        ),
      ),
    );
  }
}
