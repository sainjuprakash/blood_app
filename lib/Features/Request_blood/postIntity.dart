import 'package:blood_app/Features/Login/entities/enteties.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../Login/model/user_model.dart';

class PostIntity extends Equatable {
  String postID;
  String fullname;
  String patientname;
  String purpose;
  String bloodgroup;
  int pins;
  int contact;
  String location;
  String dateofrequire;
  DateTime createdAt;
  MyUser myuser;

  PostIntity(
      {required this.postID,
      required this.fullname,
      required this.patientname,
      required this.purpose,
      required this.bloodgroup,
      required this.pins,
        required this.contact,
      required this.location,
      required this.dateofrequire,
      required this.createdAt,
      required this.myuser});

  Map<String, Object> toDocument() {
    return {
      'postID': postID,
      'fullname': fullname,
      'patientname': patientname,
      'purpose': purpose,
      'bloodgroup': bloodgroup,
      'pins': pins,
      'contact' : contact,
      'location': location,
      'dateofrequire': dateofrequire,
      'createdAt': createdAt,
      'user': myuser.toEntity().toDocument()
    };
  }

  static PostIntity fromDocument(Map<String, dynamic> doc) {
    return PostIntity(
        postID: doc['postID'],
        fullname: doc['fullname'],
        patientname: doc['patientname'],
        purpose: doc['purpose'],
        bloodgroup: doc['bloodgroup'],
        pins: doc['pins'],
        contact: doc['contact'],
        location: doc['location'],
        dateofrequire: doc['dateofrequire'],
        createdAt: (doc['createdAt'] as Timestamp).toDate(),
        myuser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['user'])));
  }

  @override
  String toString() {
    return '''requestBlood :{
        PostID: $postID,
        fullname: $fullname,
        patientname: $patientname,
        purpose: $purpose,
        bloodgroup: $bloodgroup,
        pins: $pins,
        location: $location,
        dateofrequire: $dateofrequire,
        createdAt: $createdAt,
        user: $myuser
  }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
