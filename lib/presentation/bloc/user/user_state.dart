part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class FriendsAndFamilyLoading extends UserState {}

class FriendsAndFamilyLoaded extends UserState {
  final FriendsAndFamily friendsAndFamily;
  FriendsAndFamilyLoaded(this.friendsAndFamily);
}

class FriendsAndFamilyError extends UserState {
  final String error;
  FriendsAndFamilyError(this.error);
}

class DeletingProfile extends UserState {
  final String message;
  DeletingProfile(this.message);
}

class ProfileDeleted extends UserState {
  final String message;
  ProfileDeleted(this.message);
}

class AddingProfile extends UserState {}

class AddingProfileError extends UserState {
  final String message;
  AddingProfileError({
    required this.message,
  });
  
}

class ProfileAdded extends UserState {
  final bool status;
  final String messsage;
  ProfileAdded({
    required this.status,
    required this.messsage,
  });
}
