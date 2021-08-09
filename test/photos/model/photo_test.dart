import 'package:evermos/models/photo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../resource/fake_response.dart';

void main() {
  group('Photo', () {
    test('supports value comparison', () {
      expect(
        Photo.fromJson(fakeResponse),
        Photo.fromJson(fakeResponse),
      );
    });
  });
}
