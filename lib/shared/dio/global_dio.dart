import 'package:dio/dio.dart';
import 'package:morphing/shared/dio/dio_helper.dart';

final Dio dio = DioHelper.getDio(
  // baseUrl: "https://mahidul-islam.github.io/history_collaborative_server/",
  baseUrl: "http://127.0.0.1:8000/",
);
