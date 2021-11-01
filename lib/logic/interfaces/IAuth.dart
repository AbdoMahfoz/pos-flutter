abstract class IAuth {
  Future<bool> login(String username, String password);
  Future<bool> isLoggedIn();
  Future<bool> logOut();
  Stream<bool> get loggedInStream;
}
