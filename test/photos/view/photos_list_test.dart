import 'package:bloc_test/bloc_test.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:evermos/ui/photos/view/photos_list.dart';
import 'package:evermos/ui/photos/widgets/progress_loader.dart';
import 'package:evermos/ui/photos/widgets/photos_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../resource/fake_response.dart';

class FakePhotoState extends Fake implements PhotoState {}

class FakePhotoEvent extends Fake implements PhotoEvent {}

class MockPhotoBloc extends MockBloc<PhotoEvent, PhotoState>
    implements PhotoBloc {}

extension on WidgetTester {
  Future<void> pumpPhotosList(PhotoBloc photoBloc) {
    return pumpWidget(MaterialApp(
      home: BlocProvider.value(
        value: photoBloc,
        child: PhotosList(),
      ),
    ));
  }
}

void main() {
  final mockPhotos = Photo.fromJson(fakeResponse);

  late PhotoBloc photoBloc;

  setUpAll(() {
    registerFallbackValue<PhotoState>(FakePhotoState());
    registerFallbackValue<PhotoEvent>(FakePhotoEvent());
  });

  setUp(() {
    photoBloc = MockPhotoBloc();
  });

  group('PhotosList', () {
    testWidgets(
        'renders CircularProgressIndicator when photo status is initial',
        (tester) async {
      when(() => photoBloc.state).thenReturn(PhotoState());
      await tester.pumpPhotosList(photoBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders no photos text when photo status is success but with 0 photos',
        (tester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: [],
        hasReachedMax: true,
      ));
      await tester.pumpPhotosList(photoBloc);
      expect(find.text('no photos'), findsOneWidget);
    });

    testWidgets(
        'renders failed to fetch photos text when photo status is failure',
        (tester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.failure,
        photos: [],
        hasReachedMax: true,
      ));
      await tester.pumpPhotosList(photoBloc);
      expect(find.text('failed to fetch photos'), findsOneWidget);
    });

    testWidgets('renders 2 photos ', (tester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: mockPhotos.photos.getRange(0, 3).toList(),
        hasReachedMax: false,
      ));
      await tester.pumpPhotosList(photoBloc);
      expect(find.byType(PhotosListItem), findsNWidgets(2));
    });

    testWidgets('does not render bottom loader when photos max is reached',
        (tester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: mockPhotos.photos,
        hasReachedMax: true,
      ));
      await tester.pumpPhotosList(photoBloc);
      expect(find.byType(ProgressLoader), findsNothing);
    });

    testWidgets('fetches more photos when scrolled to the bottom',
        (tester) async {
      when(() => photoBloc.state).thenReturn(
        PhotoState(
          status: PhotoStatus.success,
          photos: mockPhotos.photos,
          hasReachedMax: false,
          page: 1,
        ),
      );
      await tester.pumpPhotosList(photoBloc);
      await tester.drag(find.byType(PhotosList), const Offset(0, -800));
      verify(() => photoBloc.add(PhotoFetched())).called(1);
    });
  });
}
