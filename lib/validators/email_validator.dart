class EmailValidator {
  static final RegExp _emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String validate(String email) {
    if (email.isEmpty) return "The value is empty";
    if (!_emailRegEx.hasMatch(email)) return "Please enter valid email";
    return null;
  }
}
