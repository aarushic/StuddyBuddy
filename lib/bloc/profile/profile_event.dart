import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ProfileEvent {
  final String name;

  NameChanged({@required this.name});

  @override
  List<Object> get props => [name];
}

class InfoChanged extends ProfileEvent {
  final String info;

  InfoChanged({@required this.info});

  @override
  List<Object> get props => [info];
}

class PhotoChanged extends ProfileEvent {
  final File photo;

  PhotoChanged({@required this.photo});

  @override
  List<Object> get props => [photo];
}

class AgeChanged extends ProfileEvent {
  final DateTime age;

  AgeChanged({@required this.age});

  @override
  List<Object> get props => [age];
}

class GenderChanged extends ProfileEvent {
  final String gender;

  GenderChanged({@required this.gender});

  @override
  List<Object> get props => [gender];
}

class SubjectChanged extends ProfileEvent {
  final String subject;

  SubjectChanged({@required this.subject});

  @override
  List<Object> get props => [subject];
}


class LocationChanged extends ProfileEvent {
  final GeoPoint location;

  LocationChanged({@required this.location});

  @override
  List<Object> get props => [location];
}

class Submitted extends ProfileEvent {
  final String name, gender, subject, info;
  final DateTime age;
  final GeoPoint location;
  final File photo;

  Submitted(
      {@required this.name,
      @required this.info,
      @required this.gender,
      @required this.subject,
      @required this.age,
      @required this.location,
      @required this.photo});

  @override
  List<Object> get props => [location, name, info, age, gender, subject, photo];
}