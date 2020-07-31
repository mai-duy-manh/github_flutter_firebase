import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

class RegisterPage extends StatefulWidget {
  final String title = 'Registration';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              obscureText: true,
            ),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _register();
                  }
                },
                child: Text('Submit'),
              ),
            ),
            Text(
              _success == null
                  ? ''
                  : (_success
                      ? 'Successfully registered ' + _userEmail
                      : 'Registration failed'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    setState(() {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    });
  }

  FirebaseUser user;

  void _register() async {
    user = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      setState(
        () {
          _success = true;
          _userEmail = user.email;
          createRecord();
        },
      );
    } else {
      _success = false;
    }
  }

  void createRecord() async {
    await databaseReference
        .collection("users")
        .document('${user.uid}')
        .setData(UserModel(
          name: _nameController.text,
          email: _userEmail,
          weight: _weightController.text,
          height: _heightController.text,
        ).toJson());
  }
}
