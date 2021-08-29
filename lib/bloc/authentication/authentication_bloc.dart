import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield Unauthenticated();
  
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final isFirstTime =
        await _userRepository.isFirstTime(await _userRepository.getUser());

    if (!isFirstTime) {
      yield AuthenticatedButNotSet(await _userRepository.getUser());
    } else {
      yield Authenticated(await _userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}