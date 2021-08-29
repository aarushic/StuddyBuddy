import 'package:Study_Buddy/bloc/authentication/authentication_event.dart';
import 'package:Study_Buddy/bloc/blocDelegate.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:Study_Buddy/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: Home(userRepository: _userRepository)));
}