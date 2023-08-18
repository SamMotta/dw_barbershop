import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dio/dio.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  BarbershopRepositoryImpl(this.restClient);
  final RestClient restClient;

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel,
  ) async {
    switch (userModel) {
      case UserModelAdmin():
        // HACK: unnecessary_null_checks
        // ignore: unnecessary_null_checks
        final Response<List<Map<String, Object>>>(data: List(first: data)!) =
            await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            /// Coringa do JRS
            'user_id': '#userAuthRef',
          },
        );

        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );

        return Success(BarbershopModel.fromMap(data as Map<String, Object?>));
    }
  }
}
