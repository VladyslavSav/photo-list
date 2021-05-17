class AuthEvent {}

class SignInEvent extends AuthEvent {
  String email;
  String password;

  SignInEvent(
    this.email,
    this.password,
  );
}

class ProcesEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
