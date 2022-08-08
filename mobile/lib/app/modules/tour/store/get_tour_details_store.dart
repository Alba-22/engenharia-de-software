// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:turistando/app/core/services/logger/logger_service.dart';

import '../models/tour_details_model.dart';
import '../repositories/tour_repository.dart';

class GetTourDetailsStore extends ValueNotifier<GetTourDetailsState> {
  final TourRepository _repository;
  final LoggerService _logger;

  GetTourDetailsStore(
    this._repository,
    this._logger,
  ) : super(GetTourDetailsInitialState());

  Future<void> getTourDetailsById(int id) async {
    value = GetTourDetailsLoadingState();
    final result = await _repository.getTourDetailsById(id);
    result.fold(
      (l) {
        _logger.recordError(l, StackTrace.current);
        value = GetTourDetailsErrorState("Ocorreu um problema ao obter os dados do tour!");
      },
      (r) => value = GetTourDetailsSuccessState(tourDetails: r),
    );
  }
}

abstract class GetTourDetailsState {}

class GetTourDetailsInitialState extends GetTourDetailsState {}

class GetTourDetailsLoadingState extends GetTourDetailsState {}

class GetTourDetailsSuccessState extends GetTourDetailsState {
  final TourDetailsModel tourDetails;

  GetTourDetailsSuccessState({
    required this.tourDetails,
  });

  GetTourDetailsSuccessState copyWith({
    TourDetailsModel? tourDetails,
  }) {
    return GetTourDetailsSuccessState(
      tourDetails: tourDetails ?? this.tourDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tourDetails': tourDetails.toMap(),
    };
  }

  factory GetTourDetailsSuccessState.fromMap(Map<String, dynamic> map) {
    return GetTourDetailsSuccessState(
      tourDetails: TourDetailsModel.fromMap(map['tourDetails'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetTourDetailsSuccessState.fromJson(String source) =>
      GetTourDetailsSuccessState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetTourDetailsSuccessState(tourDetails: $tourDetails)';

  @override
  bool operator ==(covariant GetTourDetailsSuccessState other) {
    if (identical(this, other)) return true;

    return other.tourDetails == tourDetails;
  }

  @override
  int get hashCode => tourDetails.hashCode;
}

class GetTourDetailsErrorState extends GetTourDetailsState {
  final String message;
  GetTourDetailsErrorState(this.message);
}
