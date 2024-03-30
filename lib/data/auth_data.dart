import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/data/firestore.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password) async {
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      } catch(e){
        throw Exception("Login error");
      }
  }

  @override
  Future<void> register(
      String email, String password, String PasswordConfirm) async {
    if (PasswordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }
}