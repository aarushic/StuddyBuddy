import 'package:Study_Buddy/bloc/authentication/authentication_bloc.dart';
import 'package:Study_Buddy/bloc/authentication/authentication_event.dart';
import 'package:Study_Buddy/bloc/login/bloc.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:Study_Buddy/ui/constants.dart';
import 'package:Study_Buddy/ui/pages/my_flutter_app_icons.dart';
import 'package:Study_Buddy/ui/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Login Failed"),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }

        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Logging In..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              width: size.width,
              height: size.height,
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Container(
                    child: Image(
                    
                      image: NetworkImage('https://i.ibb.co/YNdTxPk/IMG-0586.png'),
                      height: 300,
                      width: 500,
                      
                    ),
                  ),
                  
                  Center(
                  
                    child: Text(
                      "studdy",
                      
                      style: TextStyle(
                          fontSize: size.width * 0.13, color: Colors.grey[600], fontFamily: 'Rubik-Regular'),
                    ),
                  ),
                 
                  Container(
                    
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.04,
                      color: Colors.white,
                    ),
                    
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 27.0),
                   
                    child: TextFormField(
                      controller: _emailController,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? "Invalid Email" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "email",
                        labelStyle: TextStyle(
                            color: Colors.grey[700], fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: .7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: .7),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 27.0),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? "Invalid Password"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: "password",
                        labelStyle: TextStyle(
                            color: Colors.grey[700], fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: .7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: .7),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: isLoginButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              color: isLoginButtonEnabled(state)
                                  ? Colors.purple[200]
                                  : Colors.purple[100],
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.05),
                            ),
                            child: Center(
                              child: Text(
                                "Find your Study Buddy!",
                                style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUp(
                                    userRepository: _userRepository,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Are you new? Sign up!",
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.purple[300]),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}