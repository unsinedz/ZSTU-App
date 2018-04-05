import 'dart:async';

import '../../../domain/faculty/Chair.dart';
import '../../../domain/faculty/Faculty.dart';
import '../../../domain/faculty/Group.dart';
import '../../../domain/faculty/Year.dart';
import '../ChairInfo.dart';
import '../FacultyInfo.dart';
import '../GroupInfo.dart';
import '../YearInfo.dart';

typedef Future<Faculty> FacultyLoader(String id);

abstract class FacultyProviderMixin {
  Future<Group> makeGroup(
      GroupInfo groupInfo, FacultyLoader facultyLoader) async {
    assert(groupInfo != null);

    var faculty = await facultyLoader(groupInfo.facultyId);
    var year = new Year(groupInfo.yearId, groupInfo.yearId);
    return new Group(groupInfo.id, groupInfo.name, year, faculty);
  }

  Year makeYear(YearInfo yearInfo) {
    assert(yearInfo != null);

    return new Year(yearInfo.id, yearInfo.name);
  }

  Chair makeChair(ChairInfo chairInfo) {
    assert(chairInfo != null);

    return new Chair(chairInfo.id, chairInfo.name);
  }

  Faculty makeFaculty(FacultyInfo facultyInfo) {
    assert(facultyInfo != null);

    return new Faculty(
        facultyInfo.id, facultyInfo.name, facultyInfo.abbr, facultyInfo.image);
  }
}
