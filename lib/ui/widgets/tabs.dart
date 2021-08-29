import 'package:Study_Buddy/bloc/authentication/authentication_bloc.dart';
import 'package:Study_Buddy/bloc/authentication/authentication_event.dart';
import 'package:Study_Buddy/ui/pages/matches.dart';
import 'package:Study_Buddy/ui/pages/messages.dart';
import 'package:Study_Buddy/ui/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class Tabs extends StatelessWidget {
  final userId;

  const Tabs({this.userId});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Search(
        userId: userId,
      ),
      Matches(
        userId: userId,
      ),
      Messages(
        userId: userId,
      ),
    ];

    return Theme(
      data: ThemeData(
        primaryColor: Colors.purple[200],
        accentColor: Colors.white,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              "studdy",
              style: TextStyle(fontSize: 25.0, color: Colors.white, fontFamily: 'Rubik-Regular',),
              
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TabBar(
                      tabs: <Widget>[
                        Tab(icon: Icon(Icons.search, color: Colors.white,)),
                        Tab(icon: Icon(Icons.people, color: Colors.white)),
                        Tab(icon: Icon(Icons.chat, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        ),
      ),
    );
  }
}