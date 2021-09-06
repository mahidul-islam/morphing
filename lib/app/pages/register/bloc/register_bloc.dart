import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:morphing/app/pages/register/model/register_model.dart';
import 'package:morphing/app/pages/register/repo/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  RegisterRepo _repo = RegisterRepo();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterDoneTappedEvent) {
      if (event.email == null ||
          event.email == '' ||
          event.name == null ||
          event.name == '' ||
          event.password == null ||
          event.password == '' ||
          event.passwordConfirm == null ||
          event.passwordConfirm == '') {
        yield RegisterErrorState(error: 'All Fields are required');
        yield RegisterUpdatedState();
      } else if (event.password != event.passwordConfirm) {
        yield RegisterErrorState(error: 'Password Mismatch');
        yield RegisterUpdatedState();
      } else {
        yield RegisterLoadingState();
        UserResquest _userRequest = UserResquest(
            email: event.email,
            password: event.password,
            firstName: event.name,
            lastName: event.name);
        createNewUser(userRequest: _userRequest);
      }
    } else if (event is RegisterErrorEvent) {
      yield RegisterErrorState(error: event.error);
      yield RegisterUpdatedState();
    } else if (event is RegisterSuccessEvent) {
      yield RegisterSuccessState(userResponse: event.userResponse);
      yield RegisterUpdatedState();
    }
  }

  Future<void> createNewUser({required UserResquest userRequest}) async {
    final Either<String, UserResponse> _response =
        await _repo.registerUser(userRequest: userRequest);

    _response.fold((String error) {
      add(RegisterErrorEvent(error: error));
    }, (UserResponse result) {
      add(RegisterSuccessEvent(userResponse: result));
    });
  }
}
