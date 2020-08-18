import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_with_provider/notifire/authservise_notifier.dart';
import 'package:firebase_login_with_provider/pages/home_page.dart';
import 'package:firebase_login_with_provider/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServiceNotifier>.value(
            value: AuthServiceNotifier())
      ],
      child: MaterialApp(
          home: FutureBuilder<FirebaseUser>(
        future: _auth.currentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              return Text(snapshot.error.toString());
            }
            return snapshot.hasData ? HomePage(snapshot.data) : LoginPage();
          } else {
            return LoadingCircle();
          }
        },
      )),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
