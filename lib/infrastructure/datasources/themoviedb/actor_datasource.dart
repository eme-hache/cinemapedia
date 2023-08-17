import 'package:dio/dio.dart';

import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:cinemapedia/infrastructure/mappers/mappers.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/config/constants/environment.dart';

class ActorDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theMovieDBUrl,
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final credits = CreditsResponse.fromJson(response.data);

    return credits.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
  }
}
