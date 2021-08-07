import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/repository/repository.dart';
import 'package:evermos/repository/repository_impl.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(const PhotoState());

  Repository _repository = RepositoryImpl();

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    if (event is PhotoFetched) {
      yield await _mapPhotoFetchedToState(state);
    }
  }

  Future<PhotoState> _mapPhotoFetchedToState(PhotoState state) async {
    if (state.hasReachedMax) return state;

    try {
      if (state.status == PhotoStatus.initial) {
        final photo = await _repository.getPhoto();
        return state.copyWith(
          status: PhotoStatus.success,
          photos: photo.photos,
          hasReachedMax: false,
        );
      }
      final photo = await _repository.getPhoto(state.page + 1);
      return photo.photos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PhotoStatus.success,
              photos: List.of(state.photos)..addAll(photo.photos),
              page: photo.page,
              hasReachedMax: false);
    } on Exception {
      return state.copyWith(status: PhotoStatus.failure);
    }
  }
}
