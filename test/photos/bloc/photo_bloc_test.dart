import 'package:bloc_test/bloc_test.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/repository/repository.dart';
import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../resource/fake_response.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  group('PhotoBloc', () {
    late Repository repository;
    late PhotoBloc photoBloc;

    var mockPhotos = Photo.fromJson(fakeResponse);
    var extraMockPhotos = Photo.fromJson(extraFakeResponse);
    var emptyMockPhotos = Photo.fromJson(emptyResponse);

    setUp(() {
      repository = MockRepository();
      photoBloc = PhotoBloc(repository: repository);
    });

    tearDown(() {
      photoBloc.close();
    });

    test('initial state is PhotoState()', () {
      expect(photoBloc.state, PhotoState());
    });

    group('PhotoFetched', () {
      blocTest<PhotoBloc, PhotoState>(
        'emits nothing when posts has reached maximum amount',
        build: () => photoBloc,
        seed: () => PhotoState(hasReachedMax: true),
        act: (bloc) => bloc.add(PhotoFetched()),
        expect: () => <PhotoState>[],
      );
    });

    blocTest<PhotoBloc, PhotoState>(
      'emits successful status when http fetches initial posts',
      build: () {
        when(() => repository.getPhoto()).thenAnswer((_) async {
          return Future.value(mockPhotos);
        });
        return photoBloc;
      },
      act: (bloc) => bloc.add(PhotoFetched()),
      expect: () => <PhotoState>[
        PhotoState(
          status: PhotoStatus.success,
          page: 1,
          photos: mockPhotos.photos,
          hasReachedMax: false,
        )
      ],
    );

    blocTest<PhotoBloc, PhotoState>(
      'emits failure status when http fetches photos and throw exception',
      build: () {
        when(() => repository.getPhoto()).thenThrow(Exception('oops'));
        return photoBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(PhotoFetched()),
      expect: () => <PhotoState>[PhotoState(status: PhotoStatus.failure)],
      verify: (_) {
        verify(() => repository.getPhoto()).called(1);
      },
    );
  });
}
