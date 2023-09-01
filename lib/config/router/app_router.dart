import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/config/constants/routes.dart';

final appRouter = GoRouter(initialLocation: Routes.home, routes: [
  GoRoute(
      path: '/${Routes.home.split('/').elementAt(1)}/:view',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex =
            int.parse((state.pathParameters['view'] ?? 0).toString());

        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) =>
                MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id')),
      ]),
  GoRoute(path: '/', redirect: (_, __) => Routes.home)
]);
