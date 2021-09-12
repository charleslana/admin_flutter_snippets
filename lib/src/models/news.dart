import 'package:admin_flutter_snippets/src/utils/utils.dart';

class NewsField {
  static const createdTime = 'createdTime';
}

class News {
  News({
    this.id,
    this.title,
    this.description,
    this.isDisabled = false,
    this.createdTime,
  });

  String? id;
  String? title;
  String? description;
  bool? isDisabled;
  DateTime? createdTime;

  News fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isDisabled: json['isDisabled'],
        createdTime: Utils().toDateTime(json['createdTime']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isDisabled': isDisabled,
        'createdTime': Utils.fromDateTimeToJson(createdTime),
      };
}
