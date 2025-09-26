import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rent_app/data/usecase/auth/firebase/get_current_user.dart';
import 'package:rent_app/presentation/provider/main_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rent_app/data/repositories/auth_repository_impl.dart';
import 'package:rent_app/data/repositories/rent_repository_impl.dart';
import 'package:rent_app/data/repositories/auth_repository.dart';
import 'package:rent_app/data/repositories/repository.dart';
import 'package:rent_app/data/usecase/get_unit.dart';
import 'package:rent_app/data/usecase/get_unit_detail.dart';
import 'package:rent_app/data/usecase/get_unit_types.dart';
import 'package:rent_app/data/usecase/getRoadDistanceInKm.dart';
import 'package:rent_app/data/datasource/remote_data_source.dart';

import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/presentation/provider/auth_provider.dart';
import 'package:rent_app/presentation/provider/map_provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';

import 'data/usecase/auth/firebase/login_user.dart';
import 'data/usecase/auth/firebase/logout_user.dart';
import 'data/usecase/auth/firebase/register_user.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // --------------------------
  // External dependencies
  // --------------------------=
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => http.Client());

  // --------------------------
  // Repository
  // --------------------------
  locator.registerLazySingleton<Repository>(
    () => RentRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(auth: locator()),
  );

  // --------------------------
  // Data sources
  // --------------------------
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  // --------------------------
  // Use cases
  // --------------------------
  locator.registerLazySingleton<GetUnitTypes>(
    () => GetUnitTypes(locator<Repository>()),
  );
  locator.registerLazySingleton<GetUnit>(() => GetUnit(locator<Repository>()));
  locator.registerLazySingleton<GetUnitDetail>(
    () => GetUnitDetail(locator<Repository>()),
  );
  locator.registerLazySingleton<GetRoadDistanceInKm>(
    () => GetRoadDistanceInKm(locator<Repository>()),
  );
  locator.registerLazySingleton<LoginUser>(
    () => LoginUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<RegisterUser>(
    () => RegisterUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<LogoutUser>(
    () => LogoutUser(locator<AuthRepository>()),
  );


  // --------------------------
  // Notifiers
  // --------------------------
  locator.registerLazySingleton<UnitNotifier>(
    () => UnitNotifier(
      getUnitTypes: locator<GetUnitTypes>(),
      getRecommendationsUnit: locator<GetUnit>(),
      getDetailUnit: locator<GetUnitDetail>(),
    ),
  );

  locator.registerLazySingleton<MapProvider>(
    () => MapProvider(getRoadDistanceInKm: locator()),
  );
  locator.registerLazySingleton<MainProvider>(() => MainProvider());
  locator.registerFactory(
    () => AuthProvider(
      registerUser: locator(),
      loginUser: locator(),
      logoutUser: locator(),
      getCurrentUser: locator(),
    ),
  );
  locator.registerLazySingleton<BookNotifier>(() => BookNotifier());
}
