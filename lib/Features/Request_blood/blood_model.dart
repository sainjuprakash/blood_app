import 'dart:math';

import 'package:blood_app/Features/Request_blood/postIntity.dart';
import 'package:equatable/equatable.dart';

import '../Login/model/user_model.dart';

class RequestBlood extends Equatable {
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
  MyUser user;

  RequestBlood(
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
      required this.user});

  static final empty = RequestBlood(
      postID: '',
      fullname: '',
      patientname: '',
      purpose: '',
      bloodgroup: '',
      pins: 0,
      contact: 0,
      location: '',
      dateofrequire: '',
      createdAt: DateTime.now(),
      user: MyUser.empty);

  RequestBlood CopyWith({
    String? PostID,
    String? fullname,
    String? patientname,
    String? purpose,
    String? bloodgroup,
    int? pins,
    int? contact,
    String? location,
    String? dateofrequire,
    String? details,
    DateTime? createdAt,
    MyUser? user,
  }) {
    return RequestBlood(
        postID: PostID ?? this.postID,
        fullname: fullname ?? this.fullname,
        patientname: patientname ?? this.patientname,
        purpose: purpose ?? this.purpose,
        bloodgroup: bloodgroup ?? this.bloodgroup,
        pins: pins ?? this.pins,
        contact: contact ?? this.contact,
        location: location ?? this.location,
        dateofrequire: dateofrequire ?? this.dateofrequire,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user);
  }

  PostIntity toEntity() {
    return PostIntity(
        postID: postID,
        fullname: fullname,
        patientname: patientname,
        purpose: purpose,
        bloodgroup: bloodgroup,
        pins: pins,
        contact: contact,
        location: location,
        dateofrequire: dateofrequire,
        createdAt: createdAt,
        myuser: user);
  }

  static RequestBlood fromIntity(PostIntity postIntity) {
    return RequestBlood(
        postID: postIntity.postID,
        fullname: postIntity.fullname,
        patientname: postIntity.patientname,
        purpose: postIntity.purpose,
        bloodgroup: postIntity.bloodgroup,
        pins: postIntity.pins,
        contact: postIntity.contact,
        location: postIntity.location,
        dateofrequire: postIntity.dateofrequire,
        createdAt: postIntity.createdAt,
        user: postIntity.myuser);
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
        user: $user
  }''';
  }

  @override
  List<Object?> get props => [
        postID,
        fullname,
        patientname,
        purpose,
        bloodgroup,
        pins,
        contact,
        location,
        dateofrequire,
        createdAt,
        user
      ];
}
