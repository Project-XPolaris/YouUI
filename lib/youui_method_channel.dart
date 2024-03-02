import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'youui_platform_interface.dart';

/// An implementation of [YouuiPlatform] that uses method channels.
class MethodChannelYouui extends YouuiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('youui');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
