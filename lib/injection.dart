import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rent_app/data/models/repositories/rent_repository_impl.dart';
import 'package:rent_app/data/repositories/repository.dart';
import 'package:rent_app/data/usecase/get_unit.dart';
import 'package:rent_app/presentation/provider/notifier.dart';

import 'data/datasource/remote_data_source.dart';

final locator = GetIt.instance;

void init() {

  locator.registerLazySingleton(() => UnitNotifier(getRecommendationsUnit: locator()));


  locator.registerLazySingleton(() => GetUnit(locator()));

  locator.registerLazySingleton<Repository>(
    () => RentRepositoryImpl(remoteDataSource: locator()),
  );

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
