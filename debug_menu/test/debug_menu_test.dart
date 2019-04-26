import 'package:debug_menu/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debug_menu/core/platform_version.dart';

void main() {
  const MethodChannel channel = MethodChannel(Constants.debugMenuPlatformChannel);

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test(Constants.platformVersionMethodName, () async {
    expect(await PlatformVersion.platformVersion, '42');
  });
}
