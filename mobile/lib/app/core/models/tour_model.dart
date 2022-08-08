// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TourModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String location;
  final int rate;
  final String highlightImage;

  const TourModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.rate,
    required this.highlightImage,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      location,
      rate,
      highlightImage,
    ];
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'rate': rate,
      'highlightImage': highlightImage,
    };
  }

  factory TourModel.fromMap(Map<String, dynamic> map) {
    return TourModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      rate: map['rate'] as int,
      highlightImage: map['highlightImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TourModel.fromJson(String source) =>
      TourModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
