import 'dart:developer';

import 'package:blood_app/Features/Request_blood/blood_model.dart';
import 'package:blood_app/Features/Request_blood/blood_request_repo.dart';
import 'package:blood_app/Features/Request_blood/postIntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebasePostRepository extends BloodRequestRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');
  @override
  Future<RequestBlood> createPost(RequestBlood requestblood) async {
    try {
      requestblood.postID = const Uuid().v1();
      requestblood.createdAt = DateTime.now();

      await postCollection
          .doc(requestblood.postID)
          .set(requestblood.toEntity().toDocument());

      return requestblood;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<RequestBlood>> getPost() async{
    try {
      return await postCollection.get().then((value) => value.docs
          .map(
              (e) => RequestBlood.fromIntity(PostIntity.fromDocument(e.data())))
          .toList());

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
