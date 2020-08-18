import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServiceNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser;



  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  Future crateUser({String email, String password}) async {
    var createUserResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return createUserResult;
  }

  Future loginUser({String email, String password}) async {
    try{
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result;
    }catch(e){
      throw new AuthException(e.code, e.message);
    }
  }
}

