import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';
import 'package:turistando/app/core/models/place_model.dart';

abstract class PlacesRepository {
  Future<Either<ServerFailure, List<PlaceModel>>> getPlacesByCityName(String cityName);
}

class PlacesRepositoryImpl implements PlacesRepository {
  @override
  Future<Either<ServerFailure, List<PlaceModel>>> getPlacesByCityName(String cityName) async {
    await Future.delayed(const Duration(seconds: 1));

    return const Right([
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
    ]);
  }
}
