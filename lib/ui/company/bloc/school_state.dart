
import '../../favoriteschool/model/favorite_toggle_response.dart';
import '../model/school_response.dart';

sealed class SchoolState {}

class SchoolDefault extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolSuccess extends SchoolState {
  final SchoolResponse schoolResponse;

  SchoolSuccess(this.schoolResponse);
}

class FavoriteState extends SchoolState {
  final FavoriteToggleResponse favoriteResponse;

  FavoriteState(this.favoriteResponse);
}

class SchoolError extends SchoolState {
  final String error;

  SchoolError(this.error);
}
class FavoriteError extends SchoolState {
  final String error;

  FavoriteError(this.error);
}
