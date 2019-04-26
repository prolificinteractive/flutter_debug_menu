package com.prolificinteractive.debug_menu

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.Map;


class DebugMenuPlugin(registrar: Registrar) : MethodCallHandler {

  private lateinit var registrar: Registrar

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "debug_menu")
      channel.setMethodCallHandler(DebugMenuPlugin(registrar))
    }
  }

  init {
    this.registrar = registrar
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      val map = HashMap<String, String>()
      map.put("Platform", "Android")
      map.put("Version", "${android.os.Build.VERSION.RELEASE}")
      result.success(map)
    } else if (call.method == "goToApplicationSettings") {
      openSettings()
    } else {
      result.notImplemented()
    }
  }

  private fun getActiveContext(): Context {
    return if (registrar.activity() != null) registrar.activity() else registrar.context()
  }

  private fun openSettings() {
    val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
    val uri = Uri.fromParts("package", getActiveContext().packageName, null)
    intent.data = uri
    registrar.activity().startActivityForResult(intent, 101)
  }
}
