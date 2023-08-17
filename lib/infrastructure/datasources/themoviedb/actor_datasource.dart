import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/credits_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

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
