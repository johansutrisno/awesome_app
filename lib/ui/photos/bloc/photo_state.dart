part of 'photo_bloc.dart';

enum PhotoStatus { initial, success, failure }

class PhotoState extends Equatable {
  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <Photos>[],
    this.page = 1,
    this.hasReachedMax = false,
  });

  final PhotoStatus status;
  final List<Photos> photos;
  final int page;
  final bool hasReachedMax;

  PhotoState copyWith({
    PhotoStatus? status,
    List<Photos>? photos,
    int? page,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PhotoState { status: $status, hasReachedMax: $hasReachedMax, page: $page, photos: ${photos.length} }''';
  }

  @override
  List<Object?> get props => [status, photos, page, hasReachedMax];
}
