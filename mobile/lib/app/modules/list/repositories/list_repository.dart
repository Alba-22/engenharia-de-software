import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';
import 'package:turistando/app/core/models/tour_model.dart';
import 'package:turistando/app/core/services/rest_client/rest_client_service.dart';

abstract class ListRepository {
  Future<Either<ServerFailure, List<TourModel>>> getHighlightedTours();
}

class ListRepositoryImpl implements ListRepository {
  // ignore: unused_field
  final RestClientService _restClient;

  ListRepositoryImpl(this._restClient);

  @override
  Future<Either<ServerFailure, List<TourModel>>> getHighlightedTours() async {
    return const Right([
      TourModel(
        id: 1,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
      TourModel(
        id: 2,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
      TourModel(
        id: 3,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
      TourModel(
        id: 4,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
      TourModel(
        id: 5,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
      TourModel(
        id: 6,
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
        location: "Uberlândia",
        rate: 8,
        highlightImage: "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
      ),
    ]);
  }
}
