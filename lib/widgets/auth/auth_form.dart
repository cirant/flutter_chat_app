import 'dart:io';

import 'package:appChat/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key key, this.submitFn, this.isLoading}) : super(key: key);
  final void Function(String email, String password, String username,
      File userImageFile, bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  void _imagePicker(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin)
                      UserImagePiker(
                        imagePickerFn: _imagePicker,
                      ),
                    TextFormField(
                      key: ValueKey('emailkey'),
                      validator: (val) => (val.isEmpty || !val.contains('@'))
                          ? 'Please enter a valid email address'
                          : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email address'),
                      onSaved: (val) {
                        _userEmail = val;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('usernamekey'),
                        validator: (val) => (val.isEmpty || val.length < 4)
                            ? 'please enter at least 7 character long'
                            : null,
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (val) {
                          _userName = val;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('passwordkey'),
                      validator: (val) => (val.isEmpty || val.length < 7)
                          ? 'Password must be at least 7 character long'
                          : null,
                      decoration: InputDecoration(labelText: 'Password'),
                      onSaved: (val) {
                        _userPassword = val;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: _trySubmit,
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already havean account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
