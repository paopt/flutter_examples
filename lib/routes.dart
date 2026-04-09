import 'package:go_router/go_router.dart';

import './pages/index.dart';
import './pages/filter_list/index.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => PageList()),
    GoRoute(
      path: '/filterList',
      builder: (context, state) => const FilterList(),
    ),
  ],
);
