import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/services/rest_client/rest_client_service.dart';

import '../models/tour_details_model.dart';

abstract class TourRepository {
  Future<Either<ServerFailure, TourDetailsModel>> getTourDetailsById(int id);
}

class TourRepositoryImpl implements TourRepository {
  // ignore: unused_field
  final RestClientService _restClient;

  TourRepositoryImpl(this._restClient);

  @override
  Future<Either<ServerFailure, TourDetailsModel>> getTourDetailsById(int id) async {
    await Future.delayed(const Duration(seconds: 1));

    return const Right(
      TourDetailsModel(
        title: "Rodada de Parques",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
        places: [
          PlaceModel(
            id: "a4543885-5f27-43b5-a81c-d2827119951b",
            name: "Parque do Sabiá",
            formattedAddress: "Santa Mônica, Uberlândia - MG",
            district: "Santa Mônica",
            city: "Uberlândia",
            state: "MG",
            latitude: -18.909334,
            longitude: -48.233782,
            images: [
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
            ],
            rate: 9,
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
          ),
          PlaceModel(
            id: "a4543885-5f27-43b5-a81c-d2827119951b",
            name: "Parque do Sabiá",
            formattedAddress: "Santa Mônica, Uberlândia - MG",
            district: "Santa Mônica",
            city: "Uberlândia",
            state: "MG",
            latitude: -18.909334,
            longitude: -48.233782,
            images: [
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
            ],
            rate: 9,
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
          ),
          PlaceModel(
            id: "a4543885-5f27-43b5-a81c-d2827119951b",
            name: "Parque do Sabiá",
            formattedAddress: "Santa Mônica, Uberlândia - MG",
            district: "Santa Mônica",
            city: "Uberlândia",
            state: "MG",
            latitude: -18.909334,
            longitude: -48.233782,
            images: [
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
              "https://www.uberlandia.mg.gov.br/wp-content/uploads/2019/09/sabia10.png",
            ],
            rate: 9,
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
          ),
        ],
      ),
    );
  }
}
