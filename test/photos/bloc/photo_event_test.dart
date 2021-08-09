import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhotoEvent', () {
    group('PhotoFetched', () {
      test('support value comparison', () {
        expect(PhotoFetched(), PhotoFetched());
      });
    });
  });
}
