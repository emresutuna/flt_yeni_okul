import 'package:flutter/material.dart';

import '../ui/requestlesson/model/CourseRequestSchool.dart';
import '../ui/requestlesson/Region.dart';

extension SizedBoxExtension on int {
  Widget get toHeight {
    return SizedBox(
      height: toDouble(),
    );
  }
}
extension NullableIntExtension on int? {
  int defaultOr(int defaultValue) {
    return this ?? defaultValue;
  }
}
extension DynamicToStringExtension on dynamic {
  String? toSafeString() {
    if (this == null) return null;
    return toString();
  }

}
extension SizedBoxExtensionWidth on int {
  Widget get toWidth {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension CustomRadius on num {
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  Radius get circularRadius => Radius.circular(toDouble());
}

extension EdgeInsetsExtension on num {
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());

  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());

  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());

  EdgeInsets get topLeftPadding =>
      EdgeInsets.only(top: toDouble(), left: toDouble());

  EdgeInsets get topRightPadding =>
      EdgeInsets.only(top: toDouble(), right: toDouble());
}

extension RegionDropdownExtension on List<Region> {
  List<DropdownMenuItem<Region>> toDropdownItems() {
    return map<DropdownMenuItem<Region>>((Region region) {
      return region.toDropdownItem();
    }).toList();
  }
}
extension ProvinceDropdownExtension on List<Province> {
  List<DropdownMenuItem<Province>> toDropdownItems() {
    return this.map<DropdownMenuItem<Province>>((Province province) {
      return province.toDropdownItem();
    }).toList();
  }
}
extension SchoolDropdownExtension on List<CourseRequestSchool> {
  List<DropdownMenuItem<CourseRequestSchool>> toDropdownItems() {
    return this.map<DropdownMenuItem<CourseRequestSchool>>((CourseRequestSchool school) {
      return school.toDropdownItem();
    }).toList();
  }
}
