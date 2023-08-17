import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dio/dio.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl(this.restClient);

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel,
  ) async {
    switch (userModel) {
      case UserModelAdmin():
        final Response(
          data: List(first: data),
        ) = await restClient.auth.get('/barbershop', queryParameters: {
          /// Coringa do JRS
          'user_id': '#userAuthRef',
        });

        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );

        return Success(BarbershopModel.fromMap(data));
    }
  }
}
