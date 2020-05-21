// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);



class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String _contactText;

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
//    _googleSignIn.signInSilently();
    signInSilent();
  }

  Future<void>  signInSilent() async{
    if((await _googleSignIn.signInSilently())!= null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {"userName": _currentUser.displayName , "userEmail": _currentUser.email});
    }
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
      await _googleSignIn.signIn();
      Navigator.pushReplacementNamed(context, '/home',arguments: {"userName": _currentUser.displayName , "userEmail": _currentUser.email});
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image.asset('images/go_study_logo.jpg'),
        FlatButton(
          child: Image.asset(
            'images/google_sign_in_button.png',
            width: 200.0,
          ),
          padding: EdgeInsets.all(0.0),
          onPressed: _handleSignIn,
        ),
      ],
    );



//    if (_currentUser != null) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          ListTile(
//            leading: GoogleUserCircleAvatar(
//              identity: _currentUser,
//            ),
//            title: Text(_currentUser.displayName ?? ''),
//            subtitle: Text(_currentUser.email ?? ''),
//          ),
//          const Text("Signed in successfully."),
//          Text(_contactText ?? ''),
//          RaisedButton(
//            child: const Text('SIGN OUT'),
//            onPressed: _handleSignOut,
//          ),
//          RaisedButton(
//            child: const Text('REFRESH'),
//            onPressed: _handleGetContact,
//          ),
//        ],
//      );
//    } else {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          Image.asset('images/go_study_logo.jpg'),
//          FlatButton(
//            child: Image.asset(
//              'images/google_sign_in_button.png',
//              width: 200.0,
//            ),
//            padding: EdgeInsets.all(0.0),
//            onPressed: _handleSignIn,
//          ),
//        ],
//      );
//    }
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


//  String getUserName(){
//    print("user name is ${_currentUser.displayName ?? ''}");
//    return _currentUser.displayName ?? '';
//  }
//
//  String getUserEmail(){
//    print("user mail is ${_currentUser.email ?? ''}");
//    return _currentUser.email ?? '';
//  }

  void signOut(BuildContext context){
    _handleSignOut();
    Navigator.pushReplacementNamed(context, '/signIn');
    return;
  }
}
