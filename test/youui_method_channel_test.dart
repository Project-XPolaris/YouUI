import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youui/youui_method_channel.dart';

void main() {
  MethodChannelYouui platform = MethodChannelYouui();
  const MethodChannel channel = MethodChannel('youui');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
