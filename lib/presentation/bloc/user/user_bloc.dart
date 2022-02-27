import 'package:astro_tak/data/models/friends_and_family.dart';
import 'package:astro_tak/data/repositories/add_profile_payload.dart';
import 'package:astro_tak/data/repositories/user/profile/user_profile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:astro_tak/presentation/bloc/auth/auth_cubit.dart';

import '../../screens/profile/profile_tab.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthCubit auth;
  UserBloc(
    this.auth,
  ) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      //Get Relatives details
      if (event is GetFriendsAndFamily) {
        emit(FriendsAndFamilyLoading());
        if (auth.isAuthenticated) {
          try {
            final relatives =
                await UserProfileAPI(auth.authToken).getFriendsAndFamily();
            emit(FriendsAndFamilyLoaded(relatives));
          } catch (e) {
            emit(FriendsAndFamilyError(e.toString()));
          }
        } else {
          emit(FriendsAndFamilyError("Not Authenticated"));
        }
      }

      //Delete Relative

      else if (event is DeleteFriendOrFamilyMember) {
        emit(DeletingProfile("Deleting profile..."));
        if (auth.isAuthenticated) {
          try {
            await UserProfileAPI(auth.authToken)
                .deleteFriendOrFamilyMember(event.id);
            add(GetFriendsAndFamily());
            emit(ProfileDeleted("Profile Deleted..."));
          } catch (e) {
            emit(FriendsAndFamilyError(e.toString()));
          }
        }
      } else if (event is AddNewProfileEvent) {
        emit(AddingProfile());

        try {
          await UserProfileAPI(auth.authToken)
              .addRelativeProfile(event.addProfilePayLoad);
          emit(ProfileAdded(status: true, messsage: "Profile Added..."));
        } catch (e) {
          emit(AddingProfileError(message: "Failed to add profile..."));
        }
      }
    });
  }
}
