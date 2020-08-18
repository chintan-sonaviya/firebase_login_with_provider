import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_with_provider/notifire/authservise_notifier.dart';
import 'package:firebase_login_with_provider/pages/home_page.dart';
import 'package:firebase_login_with_provider/student_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class Register_Page extends StatefulWidget {
  @override
  _Register_PageState createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  final GlobalKey<FormBuilderState> _key = new GlobalKey<FormBuilderState>();

  String email, password;

  final att_email = 'Email';
  final att_password = 'Password';

  final FocusNode focus_email = new FocusNode();
  final FocusNode focus_password = new FocusNode();
  final _auth = FirebaseAuth.instance;
  FirebaseUser currentUSer;

  Student student = new Student();

  @override
  Widget build(BuildContext context) {
    final AuthServiceNotifier authServiceNotifier = Provider.of<
        AuthServiceNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _key,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: att_email,
                  focusNode: focus_email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validators: [
                    FormBuilderValidators.email(
                        errorText: 'Please enter valid Email Address'),
                    FormBuilderValidators.required(
                        errorText: 'Please enter the Email Address')
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                FormBuilderTextField(
                  attribute: att_password,
                  focusNode: focus_password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please enter the password ')
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      student.email = _key
                          .currentState.fields[att_email].currentState.value;
                      student.password = _key
                          .currentState.fields[att_password].currentState.value;
                      print(password);
                      print(email);

                      student.studentList.add(student.email);
                      student.studentList.add(student.password);

                      try {
                        final userNew =  await authServiceNotifier.crateUser(
                            email: student.email, password: student.password);

                        if (userNew != null) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) {
                                return HomePage(currentUSer);
                              }));
                        }
                        else{
                          return _buildErrorDialog(
                              context, "Try Again...");
                        }
                      } on AuthException catch (error) {
                        return _buildErrorDialog(context, error.toString());
                      }
                    }
                  },
                ),
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