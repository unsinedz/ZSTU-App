import 'dart:async';

abstract class IAssetManager {
  Future<bool> assetExists(String subPath);

  String getAssetPath(String name);
}
