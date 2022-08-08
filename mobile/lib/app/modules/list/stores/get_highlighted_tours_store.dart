// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:turistando/app/core/models/tour_model.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';

import '../repositories/list_repository.dart';

class GetHighlightedToursStore extends ValueNotifier<GetHighlightedToursState> {
  final ListRepository _repository;
  final LoggerService _logger;

  GetHighlightedToursStore(
    this._repository,
    this._logger,
  ) : super(GetHighlightedToursInitialState());

  Future<void> getHighlightedTours() async {
    value = GetHighlightedToursLoadingState();
    final result = await _repository.getHighlightedTours();
    result.fold(
      (l) {
        _logger.recordError(l, StackTrace.current);
        value = GetHighlightedToursErrorState("Ocorreu um erro ao obter os tours");
      },
      (r) => value = GetHighlightedToursSuccessState(tours: r),
    );
  }
}

abstract class GetHighlightedToursState {}

class GetHighlightedToursInitialState extends GetHighlightedToursState {}

class GetHighlightedToursLoadingState extends GetHighlightedToursState {}

class GetHighlightedToursSuccessState extends GetHighlightedToursState {
  final List<TourModel> tours;

  GetHighlightedToursSuccessState({
    required this.tours,
  });
}

class GetHighlightedToursErrorState extends GetHighlightedToursState {
  final String message;
  GetHighlightedToursErrorState(this.message);
}
