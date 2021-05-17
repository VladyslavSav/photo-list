import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../contollers/token_controller.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc {
  final TokenController _tokenController = TokenController.instance;
  final _inputEventController = StreamController<AuthEvent>();
  final _outputStateController = StreamController<AuthState>();

  StreamSink<AuthEvent> get inputEventSink => _inputEventController.sink;
  Stream<AuthState> get outputStateStream => _outputStateController.stream;

  AuthBloc() {
    _inputEventController.stream.listen(_handle);
  }

  void _handle(AuthEvent event) {
    if (event is SignInEvent) {
      _signIn(event.email, event.password);
    } else if (event is SignOutEvent) {
      _outputStateController.add(AuthState.Proces);
      _signOut();
    } else if (event is ProcesEvent) {
      _outputStateController.add(AuthState.Proces);
      if (_tokenController.token == null) {
        _tokenController.load();
      }
      _outputStateController.sink.add(AuthState.SignOuted);
    }
  }

  Future<void> _signIn(String email, String password) async {
    var url = Uri.parse('https://private-5548f0-photo11.apiary-mock.com/auth');
    try {
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
          _outputStateController.sink.add(AuthState.SignIned);
        }
      }
    } catch (e) {
      _outputStateController.addError(e);
    }
  }

  void _signOut() {
    _tokenController.delete();
    _outputStateController.sink.add(AuthState.SignOuted);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
