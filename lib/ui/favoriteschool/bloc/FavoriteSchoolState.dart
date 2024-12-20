import '../model/FavoriteSchoolResponse.dart';

abstract class FavoriteSchoolState {}

class FavoriteSchoolDefault extends FavoriteSchoolState {}

class FavoriteSchoolLoading extends FavoriteSchoolState {}

class FavoriteToggleTrue extends FavoriteSchoolState {}

class FavoriteToggleFalse extends FavoriteSchoolState {}

class FavoriteSchoolSuccess extends FavoriteSchoolState {
  final FavoriteSchoolResponse favoriteSchoolResponse;

  FavoriteSchoolSuccess(this.favoriteSchoolResponse);
}

class FavoriteSchoolError extends FavoriteSchoolState {
  final String error;

  FavoriteSchoolError(this.error);
}
