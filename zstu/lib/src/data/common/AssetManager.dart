import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import '../../domain/common/IAssetManager.dart';

class AssetManager implements IAssetManager {
  AssetManager(this._assetPath) : assert(_assetPath != null);
  
  String _assetPath;

  Future<bool> assetExists(String subPath) async {
    if (subPath == null)
      throw new ArgumentError("Subpath is null.");

    try {
      await rootBundle.load(getAssetPath(subPath));
    } catch(e) {
      return false;
    }
    
    return true;
  }

  String getAssetPath(String name) {
    if (name == null)
      throw new ArgumentError("Name is null.");

    return path.join(_assetPath, name);
  }
}