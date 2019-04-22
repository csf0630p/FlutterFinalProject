import 'package:flutter/material.dart';
import 'browse_posts_activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/loginPage';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _sKey = GlobalKey<ScaffoldState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _sKey,
      backgroundColor: Colors.white,
      body: new Center(
            child: Center(
              child: new ListView(
                shrinkWrap: true,
                padding: new EdgeInsets.only(left: 30.0,right: 30.0),
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        userNameSection(),
                        SizedBox(height: 8.0),
                        passwordSection(),
                      ],
                    ),
                  ),
                  SizedBox(height: 36.0,),
                  buttonSection(),
                ],
              ),
            ),
          ),
    );
  }

  Widget userNameSection() {
    return new TextFormField(
      validator: (input){
        if(input.isEmpty) {
          return 'Email required';
        }
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'pppppp@ppp.com',
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
      onSaved: (input) => _email = input,
    );
  }

  Widget passwordSection() {
    return new TextFormField(
      validator: (input) {
        if(input.isEmpty) {
          return 'Please enter your password';
        }
      },
      autofocus: false,
      initialValue: 'pppppp',
      obscureText: true,
      decoration:  new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
      onSaved: (input) => _password = input,
    );
  }

  Widget buttonSection() {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            signIn();
          },
          color: Colors.blueAccent,
          child: new Text('Sign In',style: new TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.of(context).pushNamedAndRemoveUntil(
            BrowsePage.routeName, (Route<dynamic> route) => false);
      } catch(e) {
        final snackBar = SnackBar(
          content: Text(e.message),
        );
        _sKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}

