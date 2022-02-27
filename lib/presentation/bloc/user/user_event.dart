part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetFriendsAndFamily extends UserEvent {}

class DeleteFriendOrFamilyMember extends UserEvent {
  final String id;
  DeleteFriendOrFamilyMember(this.id);
}

class AddNewProfileEvent extends UserEvent {
  final AddProfilePayLoad addProfilePayLoad;
  AddNewProfileEvent({
    required this.addProfilePayLoad,
  });
}
