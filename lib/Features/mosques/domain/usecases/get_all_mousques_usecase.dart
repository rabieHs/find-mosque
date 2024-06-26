import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/repository/places_repository.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/parameters/get_mosques_parameters.dart';
import 'package:find_mosques/core/error/failure.dart';

class GetAllMusquesUsecase
    extends BaseUsecase<List<Location>, GetMosquesParameters> {
  final PlacesRepository repository;

  GetAllMusquesUsecase({required this.repository});
  @override
  Future<Either<Failure, List<Location>>> call(
      GetMosquesParameters parameter) async {
    return await repository.getAllMosques(
        parameter.latitude, parameter.longitude);
  }
}
