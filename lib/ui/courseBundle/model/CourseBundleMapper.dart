import 'package:baykurs/ui/courseBundle/model/CourseBundleResponse.dart';

import 'CourseBundleUiModel.dart';

CourseBundleUiModel mapCourseBundleToUiModel(CourseBundleResponse response) {
  return CourseBundleUiModel.fromEntity(response.data ?? CourseBundle());
}