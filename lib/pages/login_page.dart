import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_with_provider/notifire/authservise_notifier.dart';
import 'package:firebase_login_with_provider/pages/home_page.dart';
import 'package:firebase_login_with_provider/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  String email, password;

  final String att_email = 'Email';
  final String att_password = 'password';

  final FocusNode focusNode_email = new FocusNode();
  final FocusNode focusNode_password = new FocusNode();

  final _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    final AuthServiceNotifier authServiceNotifier =
        Provider.of<AuthServiceNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: att_email,
                  focusNode: focusNode_email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                  validators: [
                    FormBuilderValidators.email(
                        errorText: "Please Enter valid email address"),
                    FormBuilderValidators.required(
                        errorText: "Please Enter the Email Address"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  attribute: att_password,
                  focusNode: focusNode_password,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "Please Enter the Email Address"),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  child: Text("Sign In "),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      email = _key
                          .currentState.fields[att_email].currentState.value;
                      password = _key
                          .currentState.fields[att_password].currentState.value;
                      print(email);
                      print(password);

                      try {
                        final userNew  = await authServiceNotifier.loginUser(
                            email: email, password: password);

                        if (userNew != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return HomePage(currentUser);
                          }));
                        } else {
                          _buildErrorDialog(context, "Try Again...");
                        }
                      } catch (e) {
                        _buildErrorDialog(context, "Try Again...");
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  child: Text("Create account.."),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Register_Page();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
