abstract class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String _email;
  final String _password;

  String get email => _email;
  String get password => _password;

  SignInEvent(this._email, this._password);
}

class SignOutEvent extends AuthenticationEvent {}

class InitializingEvent extends AuthenticationEvent {}
