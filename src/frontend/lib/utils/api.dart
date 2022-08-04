import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import './constants.dart';
import './state.dart';

class ApiClient {
  Dio? dio;

  Future<Dio> getDioInstance() async {
    if (kIsWeb) {
      BaseOptions options = BaseOptions(
        baseUrl: apiUrl,
        headers: {
          'Accept': 'application/json',
        },
      );
      dio = DioForBrowser(options);
      var adapter = BrowserHttpClientAdapter();
      // This property will automatically set cookies
      adapter.withCredentials = true;
      dio!.httpClientAdapter = adapter;
      return dio!;
    } else {
      dio = Dio();
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      final cj = PersistCookieJar(
          ignoreExpires: false, storage: FileStorage('$appDocPath/.cookies/'));
      dio!.interceptors.add(CookieManager(cj));
      return dio!;
    }
  }

  Options getRequestOptions(ApiObject header) {
    const ignoredStatuses = [400, 401, 403, 404];
    return Options(
      headers: header,
      followRedirects: false,
      validateStatus: (status) {
        if (ignoredStatuses.contains(status) || status == null) return true;
        return isStatusOk(status);
      },
    );
  }

  Future<Response?> fetch(String endpoint, String method,
      {ApiObject data = const {},
      ApiObject header = const {},
      ApiObject queryParams = const {},
      required WidgetRef ref}) async {
    final Response response;
    final requestOptions = getRequestOptions(header);
    final dioInstance = dio ??
        await getDioInstance(); // Patch to get around async initialization

    switch (method.toUpperCase()) {
      case 'GET':
        response = await dioInstance.get(endpoint,
            queryParameters: queryParams, options: requestOptions);
        break;

      case 'POST':
        response = await dioInstance.post(endpoint,
            queryParameters: queryParams, data: data, options: requestOptions);
        break;

      case 'PATCH':
        response = await dioInstance.patch(endpoint,
            queryParameters: queryParams, data: data, options: requestOptions);
        break;

      case 'PUT':
        response = await dioInstance.put(endpoint,
            queryParameters: queryParams, data: data, options: requestOptions);
        break;

      default:
        throw Exception('Unsupported http method $method');
    }

    if ([401, 403].contains(response.statusCode)) {
      ref.read(applicationStateProvider.notifier).setIsLoggedIn(false);
      return null;
    }

    return response;
  }
}

bool isStatusOk(int statusCode) {
  return statusCode >= 200 && statusCode <= 299;
}

bool? isResponseOk(Response? response) {
  if (response == null) return null;
  if (response.statusCode == null) return null;
  return isStatusOk(response.statusCode!);
}
