import 'package:cinemapedia/domain/repositories/repositories.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';

class ActorRepository extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepository(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
