import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topic_details_event.dart';
part 'topic_details_state.dart';

class TopicDetailsBloc extends Bloc<TopicDetailsEvent, TopicDetailsState> {
  TopicDetailsBloc() : super(TopicDetailsInitial());

  @override
  Stream<TopicDetailsState> mapEventToState(
    TopicDetailsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
