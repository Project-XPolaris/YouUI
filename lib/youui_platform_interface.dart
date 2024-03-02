import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'youui_method_channel.dart';

abstract class YouuiPlatform extends PlatformInterface {
  /// Constructs a YouuiPlatform.
  YouuiPlatform() : super(token: _token);

  static final Object _token = Object();

  static YouuiPlatform _instance = MethodChannelYouui();

  /// The default instance of [YouuiPlatform] to use.
  ///
  /// Defaults to [MethodChannelYouui].
  static YouuiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YouuiPlatform] when
  /// they register themselves.
  static set instance(YouuiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
