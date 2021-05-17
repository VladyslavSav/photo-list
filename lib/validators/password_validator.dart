class PasswordValidator {
  int _len = 2;

  String validate(String password) {
    if (password.isEmpty) return "The value is empty";
    if (password.length < _len)
      return "Password must have more than $_len characters";
    return null;
  }
}
