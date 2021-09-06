part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterUpdatedState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState({required this.userResponse});
  final UserResponse userResponse;

  @override
  List<Object?> get props => [userResponse];
}

class RegisterErrorState extends RegisterState {
  const RegisterErrorState({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
