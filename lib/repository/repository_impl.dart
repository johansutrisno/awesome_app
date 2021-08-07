import 'package:evermos/models/photo.dart';
import 'package:evermos/repository/remote/remote_repository.dart';
import 'package:evermos/repository/repository.dart';

import 'local/local_repository.dart';

class RepositoryImpl implements Repository {
  final LocalRepository local;
  final RemoteRepository remote;

  static final RepositoryImpl _singleton = RepositoryImpl._internal(
    remote: RemoteRepository(),
    local: LocalRepository(),
  );

  factory RepositoryImpl() {
    return _singleton;
  }

  RepositoryImpl._internal({
    required this.remote,
    required this.local,
  });

  @override
  Future<Photo> getPhoto([int page = 0]) {
    return remote.getPhoto(page: page);
  }
}
