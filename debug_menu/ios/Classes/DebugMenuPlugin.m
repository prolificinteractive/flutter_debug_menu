#import "DebugMenuPlugin.h"
#import <debug_menu/debug_menu-Swift.h>

@implementation DebugMenuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDebugMenuPlugin registerWithRegistrar:registrar];
}
@end
