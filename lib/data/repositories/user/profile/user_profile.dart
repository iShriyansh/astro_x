import 'dart:convert';

import 'package:astro_tak/data/repositories/add_profile_payload.dart';
import 'package:dio/dio.dart';

import 'package:astro_tak/data/models/friends_and_family.dart';

import '../../../../config/config.dart';

class UserProfileAPI {
  final String token;

  UserProfileAPI(this.token);

  Future<FriendsAndFamily> getFriendsAndFamily() async {
    const String url = baseUrl + '/relative/all';
    print(token);
    var response = await Dio().get(url,
        options: Options(
          headers: {
            'authorization': token,
          },
        ));

    print(response.headers);

    if (response.statusCode == 200) {
      if (Map.castFrom(response.data).containsKey("data")) {
        return FriendsAndFamily.fromJson(response.data);
      } else {
        throw Exception('No Relatives found');
      }
    } else {
      throw Exception('Internal server error');
    }
  }

  Future deleteFriendOrFamilyMember(String id) async {
    String url = baseUrl + "/relative/delete/$id";
    print(url);
    var response = await Dio().post(
      url,
      options: Options(
        headers: {
          'authorization': token,
        },
      ),
    );
    //Todo: Handle other status codes
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Internal server error');
    }
  }

  addRelativeProfile(AddProfilePayLoad addProfilePayLoad) async {
    print("============");
    String _body = jsonEncode(addProfilePayLoad.toJson());
    String url = baseUrl + "/relative";
    print(url);
    var response = await Dio().post(url,
        options: Options(
          headers: {
            'authorization': token,
          },
        ),
        data: _body);

    print(response.statusCode);
    //Todo: Handle other status codes
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Internal server error');
    }
  }
}
