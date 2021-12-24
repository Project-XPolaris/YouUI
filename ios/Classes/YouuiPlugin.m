#import "YouuiPlugin.h"
#if __has_include(<youui/youui-Swift.h>)
#import <youui/youui-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "youui-Swift.h"
#endif

@implementation YouuiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYouuiPlugin registerWithRegistrar:registrar];
}
@end
