part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TopicListApiReqiestEvent extends HomeEvent {
  const TopicListApiReqiestEvent({this.forceRefresh = false});
  final bool forceRefresh;
  @override
  List<Object> get props => <Object>[forceRefresh];
}

class TopicListApiReqiestSuccessEvent extends HomeEvent {
  const TopicListApiReqiestSuccessEvent({required this.topicList});
  final TopicList topicList;
  @override
  List<Object> get props => <Object>[topicList];
}

class HomePageErrorEvent extends HomeEvent {
  const HomePageErrorEvent({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[error];
}
