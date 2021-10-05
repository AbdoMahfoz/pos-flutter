abstract class IAuth {
  Future<bool> login(String username, String password);
}
