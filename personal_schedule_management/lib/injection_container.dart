import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/data/datasource/local/local_database.dart';

final instance = GetIt.instance;
Future<void> initializeDependencies() async {
  instance.registerSingleton<LocalDatabase>(LocalDatabase());
}
