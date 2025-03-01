abstract class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {}
class ProfileLogoutRequested extends ProfileEvent {}
class DeleteAccount extends ProfileEvent {}