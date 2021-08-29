import 'package:Study_Buddy/bloc/search/bloc.dart';
import 'package:Study_Buddy/models/user.dart';
import 'package:Study_Buddy/repositories/searchRepository.dart';
import 'package:Study_Buddy/ui/widgets/iconWidget.dart';
import 'package:Study_Buddy/ui/widgets/profile.dart';
import 'package:Study_Buddy/ui/widgets/userGender.dart';
import 'package:Study_Buddy/ui/widgets/userSubject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatefulWidget {
  final String userId;

  const Search({this.userId});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchRepository _searchRepository = SearchRepository();
  SearchBloc _searchBloc;
  User _user, _currentUser;
  int difference;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator().getCurrentPosition();

    double location = await Geolocator().distanceBetween(37.785834,
        -122.406417, 37.785834, -122.406417);

    difference = location.toInt();
  }

  @override
  void initState() {
    _searchBloc = SearchBloc(searchRepository: _searchRepository);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: _searchBloc,
      builder: (context, state) {
        if (state is InitialSearchState) {
          _searchBloc.add(
           LoadUserEvent(userId: widget.userId),
          );
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
            ),
          );
        }
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
            ),
          );
        }
        if (state is LoadUserState) {
          _user = state.user;
          _currentUser = state.currentUser;

          getDifference(_user.location);
          if (_user.location == null) {
             
             return Text(
              ". ");
        
          } else
            return profileWidget(
              padding: size.height * 0.04,
              photoHeight: size.height * 0.824,
              photoWidth: size.width * 0.95,
              photo: _user.photo,
              clipRadius: size.height * 0.04,
              containerHeight: size.height * 0.42,
              containerWidth: size.width * 0.9,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.058),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.00,
                    ),
                    Row(
                      children: <Widget>[
                        
                        Expanded(
                          child: Text(
                            "     " +
                                _user.name +
                                ", " +
                                _user.gender,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.05, fontFamily: 'Rubik-Regular'),
                          ),
                        )
                      ],
                    ),
                    Container(
                     height: 7,
                    ),
                    Row(
                      children: <Widget>[
                        Text("               "),
                        userSubject(_user.subject),
                         Text("  "),
                        Text(
                            
                                _user.subject,
                                
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.04, fontFamily: 'Rubik-Regular'),
                        )
                      ],
                    ),
                    Container(
                     height: 17,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                        child: Text(
                       
                                _user.info,
                                
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.028, fontFamily: 'Rubik-Regular'),
                            overflow: TextOverflow.clip,
                        )
                        ),
                      ],
                    ),
                    Container(
                     height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          difference != null
                              ? (difference / 1000).floor().toString() +
                                  " km away"
                              : "0 km away",
                          style: TextStyle(color: Colors.white, fontSize: size.height * 0.02, fontFamily: 'Rubik-Regular'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                 
                        iconWidget(Icons.clear, () {
                          _searchBloc
                              .add(PassUserEvent(widget.userId, _user.uid));
                        }, size.height * 0.08, Colors.yellow[300]),
                        iconWidget(FontAwesomeIcons.heart, () {
                          _searchBloc.add(
                            SelectUserEvent(
                                name: _currentUser.name,
                                photoUrl: _currentUser.photo,
                                currentUserId: widget.userId,
                                selectedUserId: _user.uid),
                          );
                        }, size.height * 0.07, Colors.red[400]),
                        
                      ],
                    )
                  ],
                ),
              ),
            );
        } else
          return Container();
      },
    );
  }
}
