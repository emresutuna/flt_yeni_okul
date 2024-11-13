
import '../../favoriteschool/model/FavoriteToggleResponse.dart';
import '../model/SchoolResponse.dart';

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
