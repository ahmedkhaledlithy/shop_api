import 'package:dsc_shop/services/firestore.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
 late final FirebaseAuth _auth;
  User? _user;
  String? errorMessage;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }

  User? get user => _user;



  Future<void> login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: username, password: password);
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
      if (e.code == 'user-not-found') {
        errorMessage = "User not found";
        print('Hi, User not found');
      } else if (e.code == 'wrong-password') {
        errorMessage = "Your password is not correct";
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signUp(String username, String password) async {
    try {

      await _auth.createUserWithEmailAndPassword(email: username, password: password);
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      notifyListeners();

    } catch (e) {
      errorMessage=e.toString();
    }
  }

 Future<void> saveGoogleUser()async{
    final GoogleSignInAccount? currentGoogleUser =  _googleSignIn.currentUser;

    await DataBase().addUser(Users(
      id:  _user!.uid,
      username: currentGoogleUser!.email,
      password: null,
      fullName:currentGoogleUser.displayName!,
      address:null,
      phone: null,
      gender: null,
      image: currentGoogleUser.photoUrl!,
    ));
  }

Future<void> saveUser({required String fullName,required String password,required String email,
  required String address, required String phone,required String gender,required String photo})async{

   await DataBase().addUser(Users(
     id:  _user!.uid,
     username: email,
     password: password,
     fullName:fullName,
     address:address,
     phone: phone,
     gender: gender,
     image: photo,
   ));
 }




 Future<void> resetPassword(String username)async{
   await _auth.sendPasswordResetEmail(email: username.trim());
 }

  currentUser() {
    User? user = _auth.currentUser;
    return user != null ? user.uid : null;
  }



  Future<void> logout() async {
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();

    }catch (e){
      print("${e.toString()}");
    }
  }
}