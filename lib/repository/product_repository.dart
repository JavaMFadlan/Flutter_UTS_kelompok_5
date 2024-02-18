import 'dart:developer';
import 'repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class ProductRepository extends Repository {
  final Dio _dio = Dio();

  Future<String> addProduct({
    required String title,
    required String desc,
    required String date,
    required File image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'judul': title,
        'deskripsi': desc,
        'tanggal': date,
        'url_image':
            await MultipartFile.fromFile(image.path, filename: 'image.jpg'),
      });

      Response response = await _dio.post(
        'https://me-dis.000webhostapp.com/add-api.php',
        data: formData,
      );
      log('${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('failed to add information');
      }
    } catch (error) {
      log('Error: $error');
      throw Exception('Failed to add data. Error: $error');
    }
  }

  Future<List> getProductList(keyword) async {
    try {
      log("GETTING PRODUCTS");
      var dio = Dio(); // Initialize Dio
      var response = await dio.get(
        'https://me-dis.000webhostapp.com/show-api.php',
        queryParameters: {'key': keyword},
      );
      log("list $response");
      if (response.statusCode == 200) {
        List productList = response.data;
        return productList;
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle Dio errors or network issues
      log('Dio Error: $error');
      return [];
    }
  }

  Future selectInfo(String id) async {
    FormData formData = FormData.fromMap({
      'idp': id,
    });
    final response = await _dio.post(
      'https://me-dis.000webhostapp.com/list-api.php',
      data: formData,
    );
    Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);
    log("Res $responseData");
    if (responseData['success'] == true) {
      responseData['data']['status'] = true;
      return responseData['data'];
    } else {
      return {'status': false, 'msg': responseData['msg']};
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      FormData formData = FormData.fromMap({
        'idproduct': id, // Changed 'idnews' to 'idproduct'
      });
      var dio = Dio(); // Initialize Dio
      final response = await dio.post(
        'https://me-dis.000webhostapp.com/delete-api.php',
        data: formData,
      );
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw error.toString(); // Throw the error for further handling
    }
  }

  Future editInfo(
      {required String id,
      required String title,
      required String content,
      required String date,
      File? image}) async {
    try {
      FormData formData = FormData.fromMap({
        'idinfo': id,
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
      });
      if (image != null) {
        formData = FormData.fromMap({
          'idinfo': id,
          'judul': title,
          'deskripsi': content,
          'tanggal': date,
          'url_image':
              await MultipartFile.fromFile(image.path, filename: 'image.jpg'),
        });
      }

      Response response = await _dio.post(
        'https://me-dis.000webhostapp.com/edit-api.php',
        data: formData,
      );
      log("RES ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
