class AddProfilePayLoad {
  AddProfilePayLoad({
    required this.birthDetails,
    required this.birthPlace,
    required this.firstName,
    required this.lastName,
    required this.relationId,
    required this.gender,
  });
  late final BirthDetails birthDetails;
  late final BirthPlace birthPlace;
  late final String firstName;
  late final String lastName;
  late final int relationId;
  late final String gender;
  
  AddProfilePayLoad.fromJson(Map<String, dynamic> json){
    birthDetails = BirthDetails.fromJson(json['birthDetails']);
    birthPlace = BirthPlace.fromJson(json['birthPlace']);
    firstName = json['firstName'];
    lastName = json['lastName'];
    relationId = json['relationId'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['birthDetails'] = birthDetails.toJson();
    _data['birthPlace'] = birthPlace.toJson();
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['relationId'] = relationId;
    _data['gender'] = gender;
    return _data;
  }
}

class BirthDetails {
  BirthDetails({
    required this.dobDay,
    required this.dobMonth,
    required this.dobYear,
    required this.tobHour,
    required this.tobMin,
    required this.meridiem,
  });
  late final int dobDay;
  late final int dobMonth;
  late final int dobYear;
  late final int tobHour;
  late final int tobMin;
  late final String meridiem;
  
  BirthDetails.fromJson(Map<String, dynamic> json){
    dobDay = json['dobDay'];
    dobMonth = json['dobMonth'];
    dobYear = json['dobYear'];
    tobHour = json['tobHour'];
    tobMin = json['tobMin'];
    meridiem = json['meridiem'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dobDay'] = dobDay;
    _data['dobMonth'] = dobMonth;
    _data['dobYear'] = dobYear;
    _data['tobHour'] = tobHour;
    _data['tobMin'] = tobMin;
    _data['meridiem'] = meridiem;
    return _data;
  }
}

class BirthPlace {
  BirthPlace({
    required this.placeName,
    required this.placeId,
  });
  late final String placeName;
  late final String placeId;
  
  BirthPlace.fromJson(Map<String, dynamic> json){
    placeName = json['placeName'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['placeName'] = placeName;
    _data['placeId'] = placeId;
    return _data;
  }
}