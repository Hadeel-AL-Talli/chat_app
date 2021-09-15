import 'package:chat_app/ui/auth/models/RegisterRequest.dart';
import 'package:chat_app/ui/auth/providers/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signup(RegisterRequest registerRequest) async {
    try {
      UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
          email: registerRequest.email, password: registerRequest.password);
      return userCredential;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        RouteHelper.routeHelper.showCustomDialoug('User Not Found');
      } else if (e.code == 'wrong-password') {
        RouteHelper.routeHelper.showCustomDialoug('Wrong Password');
      }
    } catch (e) {}
  }

  resetPassword(String email) {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  verifyEmail() {
    firebaseAuth.currentUser.sendEmailVerification();
  }

  logout() async {
    await firebaseAuth.signOut();
  }

  bool checkUser() {
    return firebaseAuth.currentUser != null;
  }

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }
}

