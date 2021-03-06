import 'dart:async';
import 'dart:convert' show json;
import 'package:firebase_auth/firebase_auth.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

import '../Global.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

final FirebaseAuth _auth= FirebaseAuth.instance;


class SignIn extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<SignIn> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  bool silent=true;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    signInSilent();
  }

  Future<void>  signInSilent() async{
    if((await _googleSignIn.signInSilently())!= null) {
      _handleSignIn();
      return;
    }
    silent=false;
    setState(() {});
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      FirebaseAPI().setUser(user);

      if(await UserDataBase().hasData()){
        List<String> courses=[];
        for(var course in (await UserDataBase().getUser()).getCourses()){
          courses.add(course.toString());
        }
        Global().setUserCourses(courses);
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        Navigator.pushReplacementNamed(context, '/getInfo');
      }
    } catch (error) {
      print(error);
    }

  }

  Future<void> _handleSignOut() {
    _googleSignIn.disconnect();
    _auth.signOut();
    return null;
  }

  Widget _buildBody() {
    if (silent){
      return Loading();
    }
    return Scaffold(
      backgroundColor: Global.getBackgroundColor(0),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('images/go_study_logo.jpg'),
              FlatButton(
                child: Image.asset(
                  'images/google_sign_in_button.png',
                  width: MediaQuery.of(context).size.width *2/3,
                ),
                onPressed: _handleSignIn,
              ),
            ],
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }


  void signOut(BuildContext context){
    _handleSignOut();
    Navigator.pushReplacementNamed(context, '/signIn');
    return;
  }
}
