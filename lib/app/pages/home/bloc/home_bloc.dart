import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/app/pages/home/repo/home_repo.dart';
import 'package:pedantic/pedantic.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    homeInit();
  }

  final TopicListRepo _repo = TopicListRepo();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is TopicListApiReqiestEvent) {
      yield HomePageLoadingState();
      unawaited(requestTopicListInfo(forceRefresh: event.forceRefresh));
      // yield HomePageUpdatedState();
    } else if (event is TopicListApiReqiestSuccessEvent) {
      yield TopicListApiReqiestSuccessState(topicList: event.topicList);
    } else if (event is HomePageErrorEvent) {
      yield HomePageErrorState(error: event.error);
    }
  }

  Future<void> requestTopicListInfo({bool forceRefresh = false}) async {
    final Either<String, TopicList> _response =
        await _repo.getTopicList(forceRefresh: forceRefresh);

    _response.fold((String error) {
      add(HomePageErrorEvent(error: error));
    }, (TopicList result) {
      add(TopicListApiReqiestSuccessEvent(topicList: result));
    });
  }

  void homeInit() {
    add(const TopicListApiReqiestEvent());
  }

  void homeReload() {
    add(const TopicListApiReqiestEvent(forceRefresh: true));
  }
}
