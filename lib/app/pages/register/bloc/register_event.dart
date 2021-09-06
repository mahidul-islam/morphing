part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterDoneTappedEvent extends RegisterEvent {
  const RegisterDoneTappedEvent(
      {required this.name,
      required this.passwordConfirm,
      required this.email,
      required this.password});
  final String? email;
  final String? name;
  final String? password;
  final String? passwordConfirm;

  @override
  List<Object?> get props => [email, password];
}

class RegisterErrorEvent extends RegisterEvent {
  const RegisterErrorEvent({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class RegisterSuccessEvent extends RegisterEvent {
  const RegisterSuccessEvent({required this.userResponse});
  final UserResponse userResponse;

  @override
  List<Object?> get props => [userResponse];
}
