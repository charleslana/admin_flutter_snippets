import 'package:admin_flutter_snippets/utils/utils.dart';

class NewsField {
  static const createdTime = 'createdTime';
}

class News {
  String? id;
  String title;
  String description;
  bool? isDisabled;
  DateTime? createdTime;

  News({
    this.id,
    required this.title,
    required this.description,
    this.isDisabled = false,
    this.createdTime,
  });

  static News fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isDisabled: json['isDisabled'],
        createdTime: Utils.toDateTime(json['createdTime']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isDisabled': isDisabled,
        'createdTime': Utils.fromDateTimeToJson(createdTime),
      };
}
