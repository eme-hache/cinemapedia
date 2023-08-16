import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/the_moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDBDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theMovieDBUrl,
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final theMovieDBResponse = TheMovieDbResponse.fromJson(response.data);
    final List<Movie> movies = theMovieDBResponse.results
        .where((theMovieDb) => theMovieDb.posterPath != 'no-poster')
        .map((theMovieDb) => MovieMapper.theMovieDBToEntity(theMovieDb))
        .toList();

    return movies;
  }
}
