import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../validators/email_validator.dart';
import '../validators/password_validator.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  var _hidePassword = true;
  var _signInProces = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void _saveForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      setState(() => _signInProces = true);
      _formKey.currentState.save();
      context.read<AuthenticationBloc>().add(SignInEvent(_email, _password));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildDivider(screenSize),
          Container(
            height: screenSize.height * 0.1,
            padding: EdgeInsets.symmetric(horizontal: screenSize.width / 10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenSize.width * 0.03),
                  ),
                ),
              ),
              onSaved: (email) {
                _email = email;
              },
              validator: (value) {
                return _emailValidator.validate(value);
              },
            ),
          ),
          _buildDivider(screenSize),
          Container(
            height: screenSize.height * 0.1,
            width: screenSize.width * 0.8,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenSize.width * 0.03),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () {
                    setState(() => _hidePassword = !_hidePassword);
                  },
                ),
              ),
              obscureText: _hidePassword,
              onSaved: (password) {
                _password = password;
              },
              validator: (value) {
                return _passwordValidator.validate(value);
              },
            ),
          ),
          _buildDivider(screenSize),
          Container(
            height: screenSize.height * 0.07,
            width: screenSize.width * 0.8,
            child: (_signInProces == true)
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenSize.width * 0.03),
                        ),
                      ),
                    ),
                    child: const Text('Sign In!'),
                    onPressed: () {
                      _saveForm(context);
                    }),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(Size size) {
    return SizedBox(
      height: size.height * 0.05,
    );
  }
}
