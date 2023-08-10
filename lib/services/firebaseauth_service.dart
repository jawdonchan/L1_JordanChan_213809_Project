import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  // FirebaseAuth instance
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  Future<User> signIn({String email, String password}) async {
    try {
      UserCredential ucred = await _fbAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = ucred.user;
      print("Signed In successful! userid: $ucred.user.uid, user: $user.");
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
      return null;
    } catch (e) {
      print(e.message);
      return null;
    }
  } //signIn

  Future<User> signUp({String email, String password}) async {
    try {
      UserCredential ucred = await _fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = ucred.user;
      print('Signed Up successful! user: $user');
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
      return null;
    } catch (e) {
      print(e.message);
      return null;
    }
  } //signUp

  Future<void> signOut() async {
    await _fbAuth.signOut();
  } //signOut
// update email
Future<void> updateEmail(String newEmail) async {
    try {
      User user = _fbAuth.currentUser;

      if (user != null) {
        await user.updateEmail(newEmail);
        Fluttertoast.showToast(msg: 'Email updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      User user = _fbAuth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        Fluttertoast.showToast(msg: 'Password updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    } catch (e) {
      print(e.message);
    }
  }
} //FirebaseAuthService
