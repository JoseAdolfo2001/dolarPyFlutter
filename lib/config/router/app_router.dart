

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder:(context , state) => const HomeScreen(),
      ),

      GoRoute(
        path: '/quote',
        name: QuoteScreen.name,
        builder:(context , state)  {
          final data = state.extra as QuoteDolar;
          return QuoteScreen(dolarQuote: data);
        },
      ),

    ]
  );
