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
        formattedAddress: "Parque do Sabiá",
        district: "Santa Mônica",
        city: "Uberlândia",
        state: "MG",
        latitude: -18.909334,
        longitude: -48.233782,
      ),
    ]);
  }
}
