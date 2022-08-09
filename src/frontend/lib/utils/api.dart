import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import './constants.dart';
import './state.dart';

class CSRFCookieManager extends CookieManager {
  CSRFCookieManager(CookieJar cookieJar) : super(cookieJar);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    cookieJar.loadForRequest(options.uri).then((cookies) {
      super.onRequest(options, handler);
      final csrfCookie =
          cookies.firstWhereOrNull((c) => c.name == 'csrftoken')?.value;

      if (csrfCookie != null) {
        options.headers['X-CSRFToken'] = csrfCookie;
      }
      var cookie = CookieManager.getCookies(cookies);
      if (cookie.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader] = cookie;
      }
    });
  }
}

class ApiClient {
  Dio? dio;

  Future<Dio> getDioInstance() async {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      headers: {
        'Accept': 'application/json',
      },
    );
    dio = Dio(options);
    if (!kIsWeb) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final cj = PersistCookieJar(
          ignoreExpires: false, storage: FileStorage('$appDocPath/.cookies/'));
      dio!.interceptors.add(CSRFCookieManager(cj));
    }

    return dio!;
  }

  Options getRequestOptions(ApiObject header) {
    const ignoredStatuses = [400, 401, 403, 404];
    return Options(
      headers: header,
      followRedirects: false,
      extra: {'withCredentials': true},
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

void showApiErrors(BuildContext context, Response? response) {
  if (response == null) {
    // Sometimes the response can be null if the user isn't logged in
    return;
  }
  if (isResponseOk(response) == true) {
    // If it was a successful request there won't be any errors so return
    return;
  }

  if (response.data is! Map<String, dynamic>) {
    // Check if the datatype of the response is correct
    return;
  }

  /*
    Most of the time only one error message will exist
    but just in case lets make it show all messages
  */
  List<String> errorMessages = [];

  for (MapEntry<String, dynamic> fieldError
      in (response.data as Map<String, dynamic>).entries) {
    String fieldName = fieldError.key != 'message' ? '${fieldError.key}: ' : '';
    if (fieldError.value is List) {
      errorMessages.add(fieldName + fieldError.value.join(', '));
    } else if (fieldError.value is String) {
      errorMessages.add(fieldName + fieldError.value);
    }
  }

  for (String errorMessage in errorMessages) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
