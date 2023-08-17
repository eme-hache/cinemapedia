import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repositories/repositories.dart';
import 'package:cinemapedia/infrastructure/datasources/datasources.dart';

// Repositorio inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepository(MovieDatasource());
});
