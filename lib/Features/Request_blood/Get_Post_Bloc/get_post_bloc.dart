import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../blood_model.dart';
import '../blood_request_repo.dart';

part 'get_post_event.dart';
part 'get_post_state.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  BloodRequestRepository _postRepository;
  GetPostBloc({required BloodRequestRepository postRepository})
      : _postRepository = postRepository,
        super(GetPostInitial()) {
    print('Initial state');
    on<GetPost>((event, emit) async {
      emit(GetPostLoading());
      print('loading state');
      try {
        print('enterd try');
        List<RequestBlood> fetchedblood = await _postRepository.getPost();
        print(fetchedblood);
        print('post fetched');
        emit(GetPostSuccess(fetchedblood));
        print('success state');
      } catch (e) {
        emit(GetPostFailure());
        print('post read failure');
      }
    });
  }
}
