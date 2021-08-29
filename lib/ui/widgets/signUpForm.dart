import 'package:Study_Buddy/bloc/authentication/bloc.dart';
import 'package:Study_Buddy/bloc/signup/signup_bloc.dart';
import 'package:Study_Buddy/bloc/signup/signup_event.dart';
import 'package:Study_Buddy/bloc/signup/signup_state.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignUpForm({@required UserRepository userRepository}): assert(userRepository != null),
  _userRepository = userRepository;

 
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  SignUpBloc _signUpBloc;
  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isSignUpButtonEnabled(SignUpState state){
    return isPopulated && !state.isSubmitting;
  }

  @override
    void initState() {
      _signUpBloc = BlocProvider.of<SignUpBloc>(context);

      _emailController.addListener(_onEmailChanged);
      _passwordController.addListener(_onPasswordChanged);
      
            
      
      super.initState();
    }
        
    void _onFormSubmitted(){
      _signUpBloc.add(SignUpWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text),
      );
    }
    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return BlocListener<SignUpBloc, SignUpState>(
          listener: (BuildContext context, SignUpState state){
            if(state.isFailure){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sign Up Failed"),
                          Icon(Icons.error),
                        ],
                      ),
                  )
              );
            }
            if(state.isSubmitting){
              print("isSubmitting");
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Signing up. . ."),
                          CircularProgressIndicator(),
                        ],
                      ),
                  ),
              );
            }

            if(state.isSuccess){
              print("Success");
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              Navigator.of(context).pop();
            }
          }, 

          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context,state){
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text("Sign Up", style: TextStyle(
                          fontSize: size.width * 0.13, color: Colors.grey[700], fontFamily: 'Rubik-Regular'),
                    ),
                      ),
                      Container(
                        width: size.width *.8,
                        child: Divider(
                          height: size.height *.05,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                         padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 27.0),
                        child: TextFormField(
                          controller: _emailController,
                          autovalidate: true,
                          validator: (_){
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
                         padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 27.0),
                        child: TextFormField(
                          controller: _passwordController,
                          autovalidate: true,
                          autocorrect: false,
                          obscureText: true,
                          validator: (_){
                            return !state.isPasswordValid ? "Invalid Password" : null;
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
                        padding: EdgeInsets.all(size.height *.02),
                        child: GestureDetector(
                          onTap: isSignUpButtonEnabled(state) ? _onFormSubmitted: null,
                          child: Container(
                            width: size.width *0.8,
                            height: size.height *.06,
                            decoration: BoxDecoration( 
                              color: isSignUpButtonEnabled(state) ? Colors.purple[200]: Colors.purple[100],
                              borderRadius: BorderRadius.circular(size.height * .05),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up", 
                                style: TextStyle( 
                                  fontSize: size.height * .025,
                                  color: Colors.white, fontFamily: 'Rubik-Regular'
                                ),
                              ),
                            ),
                          ),
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
    
      
    void _onEmailChanged() {
      _signUpBloc.add(EmailChanged(email: _emailController.text,));
      
    }

    void _onPasswordChanged() {
      _signUpBloc.add(PasswordChanged(password: _passwordController.text),);
    }
 
}