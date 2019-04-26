package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.prolificinteractive.debug_menu.DebugMenuPlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    DebugMenuPlugin.registerWith(registry.registrarFor("com.prolificinteractive.debug_menu.DebugMenuPlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
