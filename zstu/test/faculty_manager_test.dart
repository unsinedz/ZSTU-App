import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:zstu/src/data/faculty/FacultyManager.dart';
import 'package:zstu/src/data/faculty/provider/FacultyApiProvider.dart';
import 'package:zstu/src/data/faculty/provider/FacultyStorageProvider.dart';
import 'package:zstu/src/domain/faculty/Faculty.dart';

void main() {
  GetFaculties_NetworkOk_ApiCalledOnce();
  GetFaculties_NetworkError_ApiCalledMoreThanOnce();
}

void GetFaculties_NetworkOk_ApiCalledOnce() {
  test('GetFaculties_NetworkOk_ApiCalledOnce', () async {
    var storageMock = new FacultyStorageProviderMock();
    var apiMock = new FacultyApiProviderMock();
    var manager = _getFacultyManager(storageMock, apiMock);

    when(storageMock.getList())
        .thenAnswer((_) => new SynchronousFuture(<Faculty>[]));
    when(apiMock.getList())
        .thenAnswer((_) => new SynchronousFuture(<Faculty>[]));

    await manager.getFaculties();

    verify(apiMock.getList()).called(1);
  });
}

void GetFaculties_NetworkError_ApiCalledMoreThanOnce() {
  test('GetFaculties_NetworkError_ApiCalledMoreThanOnce', () async {
    var storageMock = new FacultyStorageProviderMock();
    var apiMock = new FacultyApiProviderMock();
    var manager = _getFacultyManager(storageMock, apiMock);

    when(storageMock.getList())
        .thenAnswer((_) => new SynchronousFuture(<Faculty>[]));
    when(apiMock.getList())
        .thenAnswer((_) => new Future(() => throw new Error()));

    await manager.getFaculties();

    verify(apiMock.getList()).called(greaterThan(1));
  });
}

FacultyManager _getFacultyManager(
    FacultyStorageProviderMock storage, FacultyApiProviderMock api) {
  return new FacultyManager(storage, api);
}

class FacultyApiProviderMock extends Mock implements FacultyApiProvider {}

class FacultyStorageProviderMock extends Mock
    implements FacultyStorageProvider {}
