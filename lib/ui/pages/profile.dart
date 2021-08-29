import 'package:Study_Buddy/bloc/profile/profile_bloc.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:Study_Buddy/ui/widgets/profileForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class Profile extends StatelessWidget {
  final _userRepository;
  final userId;

  Profile({@required UserRepository userRepository, String userId})
      : assert(userRepository != null && userId != null),
        _userRepository = userRepository,
        userId = userId;
        
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
        centerTitle: true,
        backgroundColor: Colors.cyan[900],
        elevation: 0,
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(userRepository: _userRepository),
        child: ProfileForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}