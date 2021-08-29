import 'package:Study_Buddy/bloc/login/login_bloc.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:Study_Buddy/ui/widgets/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;

  Login({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(0.000001),
      child: AppBar(
        title: Text(
          "Study Buddy",
          style: TextStyle(fontSize: 2.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        
        elevation: 0,
      ),),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userRepository: _userRepository,
        ),
        child: LoginForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}