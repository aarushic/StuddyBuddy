import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String info;
  String gender;
  String subject;
  String photo;
  Timestamp age;
  GeoPoint location;

  User({this.uid, this.name, this.info, this.gender, this.subject, this.photo, 
  this.age, this.location});

}