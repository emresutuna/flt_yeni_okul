import 'package:baykurs/ui/profile/model/EducationInformationRequest.dart';

abstract class EducationInformationEvent {}
 class FetchEducationInformation extends EducationInformationEvent{}

class UpdateEducationInformation extends EducationInformationEvent {
  final EducationInformationRequest request;

  UpdateEducationInformation({
    required this.request,
  });
}