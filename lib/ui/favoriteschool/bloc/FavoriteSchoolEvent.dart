abstract class FavoriteSchoolEvent {}

class FetchFavorites extends FavoriteSchoolEvent {}

class ToggleFavorite extends FavoriteSchoolEvent {
  final int schoolId;

  ToggleFavorite({
    required this.schoolId,
  });
}
