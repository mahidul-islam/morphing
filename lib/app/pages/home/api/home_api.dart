import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:morphing/shared/constants.dart';
import 'package:morphing/shared/dio/default_response.dart';
import 'package:morphing/shared/dio/dio_helper.dart';
import 'package:morphing/shared/dio/global_dio.dart' as global;

abstract class HomeApi {
  Future<Either<String, DefaultRes>> getTopicList({required bool forceRefresh});
}

class HttpHomeApi implements HomeApi {
  @override
  Future<Either<String, DefaultRes>> getTopicList(
      {required bool forceRefresh}) async {
    const String _url = 'topic_list.json';
    final Options options =
        await DioHelper.getDefaultOptions(forceRefresh: forceRefresh);
    try {
      final Response<dynamic> response =
          await global.dio.get(_url, options: options);
      final DefaultRes profileResponse = DefaultRes.fromJson(response.data);
      return Right<String, DefaultRes>(profileResponse);
    } catch (e) {
      print(e.toString());
      return Left<String, DefaultRes>(e.toString());
    }
  }
}

class MockHomeApi implements HomeApi {
  @override
  Future<Either<String, DefaultRes>> getTopicList(
      {required bool forceRefresh}) async {
    // await Future<bool>.delayed(const Duration(seconds: 1));

    return Right<String, DefaultRes>(
      DefaultRes.fromRawJson(
        await rootBundle.loadString(JsonPath.json_home_page),
      ),
    );
  }
}
