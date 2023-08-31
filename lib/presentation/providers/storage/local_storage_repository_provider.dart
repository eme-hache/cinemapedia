import 'package:cinemapedia/infrastructure/datasources/datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) => IsarRepository(IsarDatasource()));