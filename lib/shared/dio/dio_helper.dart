import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

mixin DioHelper {
  static Dio? _dio;
  static DioCacheManager? _manager;

  static const Duration maxApiCacheAge = Duration(hours: 1);
  static const Duration maxApiStaleAge = Duration(hours: 3);

  static Future<Options> getDefaultOptions(
      {bool isCacheEnabled = true,
      Duration cacheDuration = maxApiCacheAge,
      Duration staleDuration = maxApiStaleAge,
      bool? forceRefresh = false}) async {
    final Options apiOptions = Options(
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
      },
    );
    if (isCacheEnabled) {
      final Options cacheOptions = buildCacheOptions(cacheDuration,
          maxStale: staleDuration,
          options: apiOptions,
          forceRefresh: forceRefresh);
      return cacheOptions;
    }

    return apiOptions;
  }

  static Dio getDio({required String baseUrl}) {
    _dio ??= Dio(BaseOptions(
      contentType: 'application/json; charset=utf-8',
      baseUrl: baseUrl,
    ))
      // ..httpClientAdapter = _getHttpClientAdapter()
      ..interceptors.add(getCacheManager().interceptor)
      ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));

    return _dio!;
  }

  static DioCacheManager getCacheManager() {
    _manager ??= DioCacheManager(CacheConfig(
      defaultMaxAge: const Duration(hours: 1),
      defaultMaxStale: const Duration(days: 1),
      maxMemoryCacheCount: 25,
    ));
    return _manager!;
  }

  // // set proxy
  // static DefaultHttpClientAdapter _getHttpClientAdapter() {
  //   DefaultHttpClientAdapter httpClientAdapter;
  //   httpClientAdapter = DefaultHttpClientAdapter();
  //   httpClientAdapter.onHttpClientCreate = (HttpClient client) {
  //     client.findProxy = (uri) {
  //       return 'PROXY 192.168.0.102:8081';
  //     };
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) {
  //       return true;
  //     };
  //   };
  //   return httpClientAdapter;
  // }
}
