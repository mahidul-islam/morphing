import 'package:dartz/dartz.dart';
import 'package:morphing/app/pages/home/api/home_api.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/shared/dio/default_response.dart';

class TopicListRepo {
  final HomeApi api = MockHomeApi();
  // final HomeApi api = HttpHomeApi();

  Future<Either<String, TopicList>> getTopicList(
      {required bool forceRefresh}) async {
    final Either<String, DefaultRes> _response =
        await api.getTopicList(forceRefresh: forceRefresh);
    return _response.fold((dynamic error) {
      return Left<String, TopicList>(error.toString());
    }, (DefaultRes result) {
      return Right<String, TopicList>(
        TopicList.fromJson(result.data),
      );
    });
  }
}
