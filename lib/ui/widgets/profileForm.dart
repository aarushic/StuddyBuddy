import 'dart:io';
import 'package:Study_Buddy/bloc/authentication/authentication_bloc.dart';
import 'package:Study_Buddy/bloc/authentication/authentication_event.dart';
import 'package:Study_Buddy/bloc/profile/bloc.dart';
import 'package:Study_Buddy/repositories/userRepository.dart';
import 'package:Study_Buddy/ui/widgets/gender.dart';
import 'package:Study_Buddy/ui/widgets/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ProfileForm extends StatefulWidget {
  final UserRepository _userRepository;

  ProfileForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  String gender, subject;
  DateTime age;
  File photo;
  GeoPoint location;
  ProfileBloc _profileBloc;

  //UserRepository get _userRepository => widget._userRepository;

  bool get isFilled =>
      _nameController.text.isNotEmpty &&
      _infoController.text.isNotEmpty &&
      gender != null &&
      subject != null &&
      photo != null &&
      age != null;

  bool isButtonEnabled(ProfileState state) {
    return isFilled && !state.isSubmitting;
  }

  _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    location = GeoPoint(37.785834, -122.406417);
  }

  _onSubmitted() async {
    await _getLocation();
    _profileBloc.add(
      Submitted(
          name: _nameController.text,
          info: _infoController.text,
          age: age,
          location: location,
          gender: gender,
          subject: subject,
          photo: photo),
    );
  }

  @override
  void initState() {
    _getLocation();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<ProfileBloc, ProfileState>(
      //bloc: _profileBloc,
      listener: (context, state) {
        if (state.isFailure) {
          print("Failed");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Profile Creation Unsuccesful'),
                    Icon(Icons.error)
                  ],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          print("Submitting");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Submitting'),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print("Success!");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                  ),
                  Container(
                    width: size.width,
                    child: CircleAvatar(
                      radius: size.width * 0.3,
                      backgroundColor: Colors.transparent,
                      child: photo == null
                          ? GestureDetector(
                              onTap: () async {
                                File getPic = await FilePicker.getFile(
                                    type: FileType.image);
                                if (getPic != null) {
                                  setState(() {
                                    photo = getPic;
                                  });
                                }
                              },
                              child: Image.asset('assets/profilephoto.png'),
                            )
                          : GestureDetector(
                              onTap: () async {
                                File getPic = await FilePicker.getFile(
                                    type: FileType.image);
                                if (getPic != null) {
                                  setState(() {
                                    photo = getPic;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: size.width * 0.3,
                                backgroundImage: FileImage(photo),
                              ),
                            ),
                    ),
                  ),
                  Container(
                        height: 11,
                      ),
                  textFieldWidget(_nameController, "Name", size),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(DateTime.now().year - 0, 0, 0),
                        onConfirm: (date) {
                          setState(() {
                            age = date;
                          });
                          print(age);
                        },
                      );
                    },
                 
                    child: Text(
                      "Enter Birthday",
                      style: TextStyle(
                          color: Colors.cyan[900], fontSize: size.width * 0.07),
                    ),
                  ),
              
                  SizedBox(
                    height: 23.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02),
                        child: Text(
                          "Grade",
                          style: TextStyle(
                              color: Colors.cyan[900], fontSize: size.width * 0.07),
                        ),
                      ),
                      Container(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          genderWidget(
                              FontAwesomeIcons.checkCircle, "9th", size, gender,
                              () {
                            setState(() {
                              gender = "9th";
                            });
                          }),
                          genderWidget(
                              FontAwesomeIcons.checkCircle, "10th", size, gender, () {
                            setState(() {
                              gender = "10th";
                            });
                          }),
                           genderWidget(
                              FontAwesomeIcons.checkCircle, "11th", size, gender, () {
                            setState(() {
                              gender = "11th";
                            });
                          }),
                          genderWidget(
                            FontAwesomeIcons.checkCircle,
                            "12th",
                            size,
                            gender,
                            () {
                              setState(
                                () {
                                  gender = "12th";
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      
                      SizedBox(
                        height: size.height * 0.02,
                      ),



                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02),
                        child: Text(
                          "Subject",
                          style: TextStyle(
                              color: Colors.cyan[900], fontSize: size.width * 0.07),
                        ),
                      ),
                      Container(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          subjectWidget(FontAwesomeIcons.divide, "math", size,
                              subject, () {
                            setState(() {
                              subject = "math";
                            });
                          }),
                          subjectWidget(
                              FontAwesomeIcons.flask, "science", size, subject,
                              () {
                            setState(() {
                              subject = "science";
                            });
                          }),
                          subjectWidget(
                              FontAwesomeIcons.book, "english", size, subject,
                              () {
                            setState(() {
                              subject = "english";
                            });
                          }),
                          subjectWidget(
                            FontAwesomeIcons.globeAmericas,
                            "history",
                            size,
                            subject,
                            () {
                              setState(
                                () {
                                  subject = "history";
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  textFieldWidget(_infoController, "Info", size),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        if (isButtonEnabled(state)) {
                          _onSubmitted();
                        } else {}
                      },
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: isButtonEnabled(state)
                              ? Colors.cyan[900]
                              : Colors.cyan[600],
                          borderRadius:
                              BorderRadius.circular(size.height * 0.05),
                        ),
                        child: Center(
                            child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget textFieldWidget(controller, text, size) {
  return Padding(
    padding: EdgeInsets.all(size.height * 0.02),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle:
            TextStyle(color: Colors.cyan[900], fontSize: size.height * 0.03),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan[900], width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan[900], width: 2.0),
        ),
      ),
    ),
  );
}