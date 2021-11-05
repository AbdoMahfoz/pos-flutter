abstract class IAuth {
  Future<bool> login(String username, String password,
      {bool requireAdmin = false});

  Future<bool> isLoggedIn();

  Future<bool> logOut();

  Stream<bool> get loggedInStream;
}
