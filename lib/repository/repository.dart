import 'package:evermos/models/photo.dart';

abstract class Repository {
  Future<Photo> getPhoto([int page = 0]);
}
