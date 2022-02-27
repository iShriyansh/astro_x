import 'package:equatable/equatable.dart';

class FriendsAndFamily extends Equatable{
  FriendsAndFamily({
    required this.httpStatus,
    required this.httpStatusCode,
    required this.success,
    required this.message,
    required this.apiName,
    required this.data,
  });
  late final String httpStatus;
  late final int httpStatusCode;
  late final bool success;
  late final String message;
  late final String apiName;
  late final Data data;
  
  FriendsAndFamily.fromJson(Map<String, dynamic> json){
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['httpStatus'] = httpStatus;
    _data['httpStatusCode'] = httpStatusCode;
    _data['success'] = success;
    _data['message'] = message;
    _data['apiName'] = apiName;
    _data['data'] = data.toJson();
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class Data {
  Data({
    required this.pageNo,
    required this.numberOfElements,
    required this.pageSize,
    required this.totalElements,
    required this.totalPages,
    required this.allRelatives,
  });
  late final int pageNo;
  late final int numberOfElements;
  late final int pageSize;
  late final int totalElements;
  late final int totalPages;
  late final List<AllRelatives> allRelatives;
  
  Data.fromJson(Map<String, dynamic> json){
    pageNo = json['pageNo'];
    numberOfElements = json['numberOfElements'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    allRelatives = List.from(json['allRelatives']).map((e)=>AllRelatives.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pageNo'] = pageNo;
    _data['numberOfElements'] = numberOfElements;
    _data['pageSize'] = pageSize;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['allRelatives'] = allRelatives.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AllRelatives {
  AllRelatives({
    required this.uuid,
    required this.relation,
    required this.relationId,
    required this.firstName,
     this.middleName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.dateAndTimeOfBirth,
    required this.birthDetails,
    required this.birthPlace,
  });
  late final String uuid;
  late final String relation;
  late final int relationId;
  late final String firstName;
  late final String? middleName;
  late final String lastName;
  late final String fullName;
  late final String gender;
  late final String dateAndTimeOfBirth;
  late final BirthDetails birthDetails;
  late final BirthPlace birthPlace;
  
  AllRelatives.fromJson(Map<String, dynamic> json){
    uuid = json['uuid'];
    relation = json['relation'];
    relationId = json['relationId'];
    firstName = json['firstName'];
    middleName = null;
    lastName = json['lastName'];
    fullName = json['fullName'];
    gender = json['gender'];
    dateAndTimeOfBirth = json['dateAndTimeOfBirth'];
    birthDetails = BirthDetails.fromJson(json['birthDetails']);
    birthPlace = BirthPlace.fromJson(json['birthPlace']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uuid'] = uuid;
    _data['relation'] = relation;
    _data['relationId'] = relationId;
    _data['firstName'] = firstName;
    _data['middleName'] = middleName;
    _data['lastName'] = lastName;
    _data['fullName'] = fullName;
    _data['gender'] = gender;
    _data['dateAndTimeOfBirth'] = dateAndTimeOfBirth;
    _data['birthDetails'] = birthDetails.toJson();
    _data['birthPlace'] = birthPlace.toJson();
    return _data;
  }
}

class BirthDetails {
  BirthDetails({
    required this.dobYear,
    required this.dobMonth,
    required this.dobDay,
    required this.tobHour,
    required this.tobMin,
    required this.meridiem,
  });
  late final int dobYear;
  late final int dobMonth;
  late final int dobDay;
  late final int tobHour;
  late final int tobMin;
  late final String meridiem;
  
  BirthDetails.fromJson(Map<String, dynamic> json){
    dobYear = json['dobYear'];
    dobMonth = json['dobMonth'];
    dobDay = json['dobDay'];
    tobHour = json['tobHour'];
    tobMin = json['tobMin'];
    meridiem = json['meridiem'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dobYear'] = dobYear;
    _data['dobMonth'] = dobMonth;
    _data['dobDay'] = dobDay;
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