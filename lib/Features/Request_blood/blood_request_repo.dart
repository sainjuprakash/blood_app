import 'package:blood_app/Features/Request_blood/blood_model.dart';

abstract class BloodRequestRepository{

  Future<RequestBlood> createPost(RequestBlood requestblood);
  Future<List<RequestBlood>> getPost();


}