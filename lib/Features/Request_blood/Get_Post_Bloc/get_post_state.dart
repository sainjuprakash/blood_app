part of 'get_post_bloc.dart';

sealed class GetPostState extends Equatable {
  const GetPostState();
  @override
  List<Object?> get props => [];
}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {}

final class GetPostSuccess extends GetPostState {
  final List<RequestBlood> getBlood;

 const GetPostSuccess(this.getBlood);
}

final class GetPostFailure extends GetPostState {}
