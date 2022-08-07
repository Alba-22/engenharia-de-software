import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/modules/create_tour/create_tour_page.dart';
import 'package:turistando/app/modules/entry/entry_page.dart';
import 'package:turistando/app/modules/login/login_page.dart';
import 'package:turistando/app/modules/place/place_details_page.dart';
import 'package:turistando/app/modules/register/register_page.dart';
import 'package:turistando/app/modules/splash/splash_page.dart';
import 'package:turistando/app/pages/pick_on_map/pick_on_map_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: "/entry",
      builder: (context, state) => const EntryPage(),
    ),
    GoRoute(
      path: "/pick-on-map",
      builder: (context, state) => const PickOnMapPage(),
    ),
    GoRoute(
      path: "/place-details",
      builder: (context, state) => PlaceDetailsPage(place: state.extra as PlaceModel),
    ),
    GoRoute(
      path: "/create-tour",
      builder: (context, state) => const CreateTourPage(),
    ),
  ],
);
