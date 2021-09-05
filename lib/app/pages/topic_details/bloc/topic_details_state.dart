part of 'topic_details_bloc.dart';

abstract class TopicDetailsState extends Equatable {
  const TopicDetailsState();
  
  @override
  List<Object> get props => [];
}

class TopicDetailsInitial extends TopicDetailsState {}
