import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rent_app/data/usecase/auth/get_sql_user.dart';
import 'package:rent_app/data/usecase/get_owner_detail.dart';
import 'package:rent_app/presentation/provider/owner_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/rent_repository_impl.dart';
import 'data/repositories/repository.dart';
import 'data/usecase/get_unit.dart';
import 'data/usecase/get_unit_detail.dart';
import 'data/usecase/get_unit_types.dart';
import 'data/usecase/getRoadDistanceInKm.dart';
import 'data/usecase/auth/firebase/login_user.dart';
import 'data/usecase/auth/firebase/logout_user.dart';
import 'data/usecase/auth/firebase/register_firebase_user.dart';
import 'data/usecase/auth/local/register_backend_user.dart';
import 'data/usecase/auth/register_user.dart';
import 'data/usecase/auth/logout_user.dart';
import 'data/usecase/auth/firebase/get_current_user.dart';
import 'presentation/provider/auth_provider.dart';
import 'presentation/provider/book_notifier.dart';
import 'presentation/provider/main_provider.dart';
import 'presentation/provider/map_provider.dart';
import 'presentation/provider/unit_notifier.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // --------------------------
  // External
  // --------------------------
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => http.Client());

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);

  // --------------------------
  // Data sources
  // --------------------------
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator(), auth: locator()),
  );

  // --------------------------
  // Repositories
  // --------------------------
  locator.registerLazySingleton<Repository>(
    () => RentRepositoryImpl(remoteDataSource: locator()),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      auth: locator<FirebaseAuth>(),
      remoteDataSource: locator<RemoteDataSource>(),
    ),
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
  locator.registerLazySingleton<GetSqlUser>(
    () => GetSqlUser(locator<AuthRepository>()),
  );

  locator.registerLazySingleton<LoginUser>(
    () => LoginUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<LogoutUser>(
    () => LogoutUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<RegisterFirebaseUser>(
    () => RegisterFirebaseUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<RegisterBackendUser>(
    () => RegisterBackendUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<RegisterUser>(
    () => RegisterUser(
      locator<RegisterFirebaseUser>(),
      locator<RegisterBackendUser>(),
    ),
  );
  locator.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<GetOwnerDetail>(
        () => GetOwnerDetail(locator<Repository>()),
  );

  // --------------------------
  // Providers / Notifiers
  // --------------------------
  locator.registerLazySingleton<MainProvider>(() => MainProvider());

  locator.registerLazySingleton<UnitNotifier>(
    () => UnitNotifier(
      authProvider: locator<AuthProvider>(),
      getUnitTypes: locator<GetUnitTypes>(),
      getRecommendationsUnit: locator<GetUnit>(),
      getDetailUnit: locator<GetUnitDetail>(),
    ),
  );

  locator.registerLazySingleton<MapProvider>(
    () => MapProvider(getRoadDistanceInKm: locator()),
  );

  locator.registerLazySingleton<BookNotifier>(() => BookNotifier());

  locator.registerFactory<AuthProvider>(
    () => AuthProvider(
      registerUser: locator<RegisterUser>(),
      loginUser: locator<LoginUser>(),
      logoutUser: locator<LogoutUser>(),
      getCurrentUser: locator<GetCurrentUser>(),
      registerBackend: locator<RegisterBackendUser>(),
      registerFirebaseUser: locator<RegisterFirebaseUser>(),
      getSqlUser: locator<GetSqlUser>(),
    ),
  );

  locator.registerLazySingleton<OwnerNotifier>(() => OwnerNotifier(
    getOwnerDetail: locator<GetOwnerDetail>()
  ));
}
