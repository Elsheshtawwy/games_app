import 'package:firebase_auth/firebase_auth.dart';
import 'package:games_app/providers/base_provider.dart';

class Auth_Provider extends BaseProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;
  Future<bool> login(String email, String password) async {
    setBusy(true);
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      setBusy(false);
      return true;
    } else {
      setBusy(false);
      return false;
    }
  }

  Future<bool> createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      {
        setBusy(false);
        return true;
      }
    } else {
      setBusy(false);
      return true;
    }
  }

  Future<bool> logout() async {
    setBusy(true);
    await firebaseAuth.signOut();
    return true;
  }
}
