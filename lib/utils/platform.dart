import 'dart:io' as io show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Stand-in for dart:io's [io.Platform] that also works on the web, where dart:io's getters throw.
/// On the web every `is*` check is false, so native-only code paths are skipped.
abstract final class Platform {
  static bool get isAndroid => !kIsWeb && io.Platform.isAndroid;
  static bool get isIOS => !kIsWeb && io.Platform.isIOS;
  static bool get isLinux => !kIsWeb && io.Platform.isLinux;
  static bool get isMacOS => !kIsWeb && io.Platform.isMacOS;
  static bool get isWindows => !kIsWeb && io.Platform.isWindows;
  static String get lineTerminator => kIsWeb ? "\n" : io.Platform.lineTerminator;
}
