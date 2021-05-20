import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../contollers/token_controller.dart';
import './authentication_event.dart';
import './authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(UnInitialized()) {
    this.add(InitializingEvent());
  }

  final TokenController _tokenController = TokenController.instance;

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    try {
      if (event is InitializingEvent) {
        await _tokenController.load();
        yield _tokenController.token == null ? SignOuted() : SignIned();
      } else if (event is SignInEvent) {
        await _signIn(event.email, event.password);
        yield SignIned();
      } else if (event is SignOutEvent) {
        _signOut();
        yield SignOuted();
      }
    } catch (e) {
      print(e);
      //yield error state
    }
  }

  Future<void> _signIn(String email, String password) async {
    var url = Uri.parse('https://private-5548f0-photo11.apiary-mock.com/auth');
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    ).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      if (result['token'] != null) {
        _tokenController.saveUpdate(result['token']);
      }
    }
  }

  void _signOut() {
    _tokenController.delete();
  }
}
