import 'package:shared_preferences/shared_preferences.dart';

class TokenController {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String _token;
  String get token => _token;

  static final TokenController instance = TokenController._construct();

  TokenController._construct();

  Future<void> saveUpdate(String token) {
    _token = token;
    return prefs.then((value) => value.setString("token", token));
  }

  Future<bool> load() {
    return prefs.then((value) {
      _token = value.getString("token");
      return (_token != null);
    });
  }

  Future<void> delete() {
    _token = null;
    return prefs.then((value) => value.remove("token"));
  }
}
