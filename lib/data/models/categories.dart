
class Categories {
  final String? httpStatus;
  final int? httpStatusCode;
  final bool? success;
  final String? message;
  final String? apiName;
  final List<Data> data;

  Categories({
    this.httpStatus,
    this.httpStatusCode,
    this.success,
    this.message,
    this.apiName,
    required this.data,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : httpStatus = json['httpStatus'] as String?,
        httpStatusCode = json['httpStatusCode'] as int?,
        success = json['success'] as bool?,
        message = json['message'] as String?,
        apiName = json['apiName'] as String?,
        data = (json['data'] as List)
            .map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'httpStatus': httpStatus,
        'httpStatusCode': httpStatusCode,
        'success': success,
        'message': message,
        'apiName': apiName,
        'data': data.map((e) => e.toJson()).toList()
      };
}

class Data {
  final int id;
  final String name;
  final String? description;
  final double? price;
  final List<String>  suggestions;

  Data({
   required this.id,
   required this.name,
    this.description,
    this.price,
    required this.suggestions,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        description = json['description'] as String?,
        price = json['price'],
        suggestions = (json['suggestions'] as List)
            .map((dynamic e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'suggestions': suggestions
      };
}
