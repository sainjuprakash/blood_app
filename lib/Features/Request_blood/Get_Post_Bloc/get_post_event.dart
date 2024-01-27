part of 'get_post_bloc.dart';

sealed class GetPostEvent extends Equatable{
  const GetPostEvent();
}
class GetPost extends GetPostEvent{

  @override
  List<Object?> get props => [];
}