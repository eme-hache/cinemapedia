import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/themoviedb/actor_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/themoviedb/actor_repository.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepository(ActorDatasource());
});
