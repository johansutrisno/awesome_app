import 'package:dio/dio.dart';
import 'package:evermos/core/server_error.dart';
import 'package:evermos/models/photo.dart';

class RemoteRepository {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.pexels.com/v1/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Authorization':
            '563492ad6f91700001000001f1e12c58209b4c4fad4b918bf67abdb7'
      },
    ),
  );

  Future<Photo> getPhoto({int? page}) async {
    try {
      var response = await dio.get('curated?per_page=10&page=${page ?? ''}');
      return Photo.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerError.withError(error: e);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
