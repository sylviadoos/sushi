// ignore_for_file: implementation_imports

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:sushi/core/errors/primary_server.dart';
import 'package:sushi/services/network/endpoints.dart';

abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> download({required String url});
}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseEndPoint,
      receiveDataWhenStatusError: true,
      //connectTimeout: const Duration(seconds: 8),
    ),
  );

  @override
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (!isMultipart) 'Accept-Encoding': '',
      if (!isMultipart) 'Cache-Control': 'no-cache',
      if (token!=null) "Authorization":"Bearer $token"
      // if (isMultipart) 'Accept-Encoding': '*',
      //if (CashHelper.sharedPreferences!.containsKey('token'))
      //'Authorization': CashHelper.getData('token'),
    };
//just for test
    dio.options.baseUrl = base ?? dio.options.baseUrl;
    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    dio.options.baseUrl = base ?? dio.options.baseUrl;
    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(
        seconds: timeOut,
      );
    }

    dio.options.headers = {
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // if (isMultipart) 'Accept': '*/*',
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (!isMultipart) 'Accept-Encoding': '',
      if (!isMultipart) 'Cache-Control': 'no-cache',
      if (token!=null)
        'Authorization': 'Bearer $token',
    };

    log('URL => ${dio.options.baseUrl + endPoint}');
    log('Header => ${dio.options.headers.toString()}');
    log('Body => $data');
    log('Query => $query');

    return await request(
      call: () async => await dio.post(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      ),
    );
  }

  @override
  Future download({required String url}) async {
    return await Dio().get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
  }

  Future uploadFormData(FormData formData, String url) async {
    Dio newDioOpj = Dio();
    return await newDioOpj.post(url,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': '*/*',
          'Accept-Encoding': '*'
          //    'Authorization': CashHelper.getData('token'),
        }),
        data: formData);

  }

 static multiPartTheFile(File? file) async {
    if (file != null) {
      multipart_file.MultipartFile fileChunks =
          await multipart_file.MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last);
      return fileChunks;
    } else {
      return null;
    }
  }
}

extension on DioHelper {
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      log("Response_Data => ${r.data}");
      debugPrint("Response_Code => ${r.statusCode}");

      return r.data;
    } on DioException catch (e) {
      debugPrint("Error_Message => ${e.message}");
      debugPrint("Error_Error => ${e.error.toString()}");
      debugPrint("Error_Type => ${e.type.toString()}");

      switch (e.type) {
        case DioExceptionType.cancel:
          throw PrimaryServerException(
            code: 100,
            error: e.toString(),
            message: "request has been canceled",
          );

        case DioExceptionType.connectionTimeout:
          throw PrimaryServerException(
            code: 100,
            error: e.toString(),
            message: "sorry! your connection has timed out!",
          );
        case DioExceptionType.sendTimeout:
          throw PrimaryServerException(
              code: 100,
              error: e.toString(),
              message: "sorry! your send request has timed out!");
        case DioExceptionType.receiveTimeout:
          throw PrimaryServerException(
              code: 100,
              error: e.toString(),
              message: "sorry! your recieve request has timed out!");
        case DioExceptionType.badResponse:
          throw PrimaryServerException(
              code: 405, error: e.toString(), message: 'Process Failed');

        default:
          throw PrimaryServerException(
              code: 100, error: e.toString(), message: 'Connection Error');
      }
    } catch (e) {
      PrimaryServerException exception = e as PrimaryServerException;

      throw PrimaryServerException(
        code: exception.code,
        error: exception.error,
        message: exception.message,
      );
    }
  }
}
