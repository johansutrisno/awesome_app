import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhotoState', () {
    test('support value comparison', () {
      expect(PhotoState(), PhotoState());
      expect(PhotoState().toString(), PhotoState().toString());
    });
  });
}
