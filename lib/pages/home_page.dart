import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_with_provider/pages/login_page.dart';
import 'package:firebase_login_with_provider/student_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  FirebaseUser currentUser;

  HomePage(this.currentUser);

  Student student = new Student();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text('Logout'),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LoginPage();
                  }));
                },
              )
            ],
          )),
      floatingActionButton: NewTaskAdd(),
    );
  }
}

class NewTaskAdd extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              size: 10,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "New list",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ), onTap: () {},)
    );
  }
}
