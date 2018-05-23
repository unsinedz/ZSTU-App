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
    if (groupInfo == null) throw new ArgumentError("GroupInfo is null.");

    var faculty = await facultyLoader(groupInfo.facultyId);
    var year = new Year(
      id: groupInfo.yearId,
      name: groupInfo.yearId,
    );
    return new Group(groupInfo.id, groupInfo.name, year, faculty);
  }

  Year makeYear(YearInfo yearInfo) {
    if (yearInfo == null) throw new ArgumentError("YearInfo is null.");

    return new Year(
      id: yearInfo.id,
      name: yearInfo.name,
    );
  }

  Chair makeChair(ChairInfo chairInfo) {
    if (chairInfo == null) throw new ArgumentError("ChairInfo is null.");

    return new Chair(chairInfo.id, chairInfo.name);
  }

  Faculty makeFaculty(FacultyInfo facultyInfo) {
    if (facultyInfo == null) throw new ArgumentError("FacultyInfo is null.");

    return new Faculty(
      id: facultyInfo.id,
      name: facultyInfo.name,
      abbr: facultyInfo.abbr,
      image: facultyInfo.image,
    );
  }
}
