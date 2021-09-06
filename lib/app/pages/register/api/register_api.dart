import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:morphing/app/pages/register/model/register_model.dart';
import 'package:morphing/shared/constants.dart';
import 'package:morphing/shared/dio/default_response.dart';
import 'package:morphing/shared/dio/dio_helper.dart';
import 'package:morphing/shared/dio/global_dio.dart' as global;

abstract class RegisterApi {
  Future<Either<String, UserResponse>> registerUser(
      {required UserResquest userRequest});
}

class HttpRegisterApi implements RegisterApi {
  @override
  Future<Either<String, UserResponse>> registerUser(
      {required UserResquest userRequest}) async {
    const String _url = 'api/v1/users/';
    final Options options =
        await DioHelper.getDefaultOptions(isCacheEnabled: false);
    try {
      final Response<dynamic> response = await global.dio.post(
        _url,
        options: options,
        data: userRequest.toJson(),
      );
      final UserResponse profileResponse = UserResponse.fromJson(response.data);
      return Right<String, UserResponse>(profileResponse);
    } catch (e) {
      print(e.toString());
      return Left<String, UserResponse>(e.toString());
    }
  }
}

class MockRegisterApi implements RegisterApi {
  @override
  Future<Either<String, UserResponse>> registerUser(
      {required UserResquest userRequest}) async {
    // await Future<bool>.delayed(const Duration(seconds: 1));

    return Right<String, UserResponse>(
      UserResponse.fromRawJson(
        await rootBundle.loadString(JsonPath.json_home_page),
      ),
    );
  }
}
