import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is SuccessNotificationEvent) {
      yield SuccessNotificationState(event.message);
      yield NotificationInitial();
    } else if (event is ErrorNotificationEvent) {
      yield ErrorNotificationState(event.message);
      yield NotificationInitial();
    } else if (event is SilentNotificationEvent) {
      yield SilentNotificationState(event.message);
      yield NotificationInitial();
    } else if (event is NoInternetConnectionNotificationEvent) {
      yield NoInternetConnectionNotificationState();
      yield NotificationUpdatedState();
    }
  }
}
