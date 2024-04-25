
class AuthService {
  final Map<String, String> _users = {}; // Almacenamiento en memoria para pruebas

  Future<void> signUp(String email, String password) async {
    // Simula el registro guardando los datos en un mapa en memoria
    if (!_users.containsKey(email)) {
      _users[email] = password;
      return;
    } else {
      throw Exception("El usuario ya está registrado");
    }
  }

  Future<bool> signIn(String email, String password) async {
    // Simula el inicio de sesión verificando los datos del mapa en memoria
    if (_users.containsKey(email) && _users[email] == password) {
      return true;
    } else {
      return false;
    }
  }
}
