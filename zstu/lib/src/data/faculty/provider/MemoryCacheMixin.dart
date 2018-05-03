import 'dart:async';

import '../../../domain/faculty/Faculty.dart';

typedef T EntityLoader<T>(String id);
abstract class MemoryCacheMixin {
  Map<String, Faculty> _loadedFaculties = {};

  Future<Faculty> getAndCacheFaculty(String id, EntityLoader<Future<Faculty>> facultyLoader) async {
    if (!_loadedFaculties.containsKey(id))
      _loadedFaculties[id] = await facultyLoader(id);

    return _loadedFaculties[id];
  }
}