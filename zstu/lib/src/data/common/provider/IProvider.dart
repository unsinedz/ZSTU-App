import 'dart:async';

abstract class IProvider<T> {
  Future<List<T>> getList();

  Future<T> getById(String id);

  Future insert(T obj);

  Future insertAll(List<T> objList);
}
