import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repositories/repositories.dart';
import 'package:cinemapedia/infrastructure/datasources/datasources.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepository(ActorDatasource());
});
