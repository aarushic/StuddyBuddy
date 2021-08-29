import 'package:Study_Buddy/bloc/signup/signup_bloc.dart';
import 'package:Study_Buddy/ui/widgets/signUpForm.dart';
import 'package:flutter/material.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  SignUp({@required UserRepository userRepository}): assert(userRepository != null),
  _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text("studdy", style: TextStyle(fontSize: 23.0)),
        backgroundColor: Colors.purple[200],
        elevation: 0,
      ),
       body: BlocProvider<SignUpBloc>(
        create: (context) =>  SignUpBloc(userRepository: _userRepository,),
        child: SignUpForm( 
          userRepository: _userRepository,
        ),
      ),
    );
  }
}