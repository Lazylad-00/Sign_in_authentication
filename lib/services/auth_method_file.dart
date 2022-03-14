import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_system/models/current_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CurrentUser? userFromFirebase(User? user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  Stream<CurrentUser?> get user {
    return _auth.authStateChanges().map(userFromFirebase);
  }

  Future signInUsingCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return userFromFirebase(user);
    } catch (e) {
      Null;
      print(e.toString());
    }
  }

  Future registerUsingCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
