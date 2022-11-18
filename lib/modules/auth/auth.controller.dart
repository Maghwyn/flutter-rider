import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/modules/auth/auth.service.dart';
import 'package:flutter_project/modules/auth/auth.state.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationServiceTemplate _authenticationService;
  final _authenticationStateStream = const AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    _authenticationStateStream.value = Authenticated(user: user);
    setupLoggedUserLocator(user);
  }

  Future<void> signUp(String name, String email, String password) async {
    final user =
        await _authenticationService.singUpCredentials(name, email, password);
    _authenticationStateStream.value = Authenticated(user: user);
    setupLoggedUserLocator(user);
  }

  Future<void> verifyEmail(String email) async {
    await _authenticationService.verifyEmail(email);
  }

  Future<void> resetPassword(String password, String email) async {
    await _authenticationService.resetPassword(password, email);
  }

  void signOut() async {
    unregisterLoggedUserLocator();
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }
}
