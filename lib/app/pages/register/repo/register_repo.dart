import 'package:dartz/dartz.dart';
import 'package:morphing/app/pages/register/api/register_api.dart';
import 'package:morphing/app/pages/register/model/register_model.dart';

class RegisterRepo {
  // final RegisterApi api = MockRegisterApi();
  final RegisterApi api = HttpRegisterApi();

  Future<Either<String, UserResponse>> registerUser(
      {required UserResquest userRequest}) async {
    final Either<String, UserResponse> _response =
        await api.registerUser(userRequest: userRequest);
    return _response;
  }
}
