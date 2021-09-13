part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();
  
  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}
