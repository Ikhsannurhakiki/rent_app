import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rent_app/data/models/repositories/rent_repository_impl.dart';
import 'package:rent_app/data/repositories/repository.dart';
import 'package:rent_app/data/usecase/get_unit.dart';
import 'package:rent_app/presentation/provider/map_provider.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';

import 'data/datasource/remote_data_source.dart';
import 'data/usecase/get_unit_detail.dart';
import 'data/usecase/get_unit_types.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(
    () => UnitNotifier(
      getUnitTypes: locator(),
      getRecommendationsUnit: locator(),
      getDetailUnit: locator(),
    ),
  );
  locator.registerLazySingleton(() => MapProvider());
  locator.registerLazySingleton(() => GetUnitTypes(locator()));
  locator.registerLazySingleton(() => GetUnit(locator()));
  locator.registerLazySingleton(() => GetUnitDetail(locator()));

  locator.registerLazySingleton<Repository>(
    () => RentRepositoryImpl(remoteDataSource: locator()),
  );

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
