part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageUpdatedState extends HomeState {}

class TopicListApiReqiestSuccessState extends HomeState {
  const TopicListApiReqiestSuccessState({required this.topicList});
  final TopicList topicList;
  @override
  List<Object> get props => <Object>[topicList];
}

class HomePageErrorState extends HomeState {
  const HomePageErrorState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[error];
}
