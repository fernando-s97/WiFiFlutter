import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_basic/wifi_basic.dart';

void main() {
  late MethodChannel methodChannel;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    methodChannel = MethodChannel(WiFiBasic.instance.channel.name);
  });

  tearDown(() {
    methodChannel.setMockMethodCallHandler(null);
  });

  // test("Must call the method channel only once", () async {
  //   methodChannel.setMockMethodCallHandler(
  //     (_) async => true
  //   );
  //
  //   await WiFiBasic.instance.isSupported();
  //   verify(() => methodChannel.invokeMethod(any())).called(1);
  //
  //   await WiFiBasic.instance.isSupported();
  //   verify(() => methodChannel.invokeMethod(any())).called(0);
  // });

  test("Must return `true` when the channel return `true`", () async {
    methodChannel.setMockMethodCallHandler((_) async => true);

    final isSupported = await WiFiBasic.instance.isSupported();

    expect(isSupported, isTrue);
  });

  test("Must return `false` when the channel return `false`", () async {
    methodChannel.setMockMethodCallHandler((_) async => false);

    final isSupported = await WiFiBasic.instance.isSupported();

    expect(isSupported, isFalse);
  });

  test("Must not handle unexpected exceptions", () {
    methodChannel
        .setMockMethodCallHandler((_) => throw PlatformException(code: ''));

    final call = () => WiFiBasic.instance.isSupported();

    expect(call(), throwsA(isA<PlatformException>()));
  });
}
