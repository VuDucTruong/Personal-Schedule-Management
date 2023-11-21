import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/data/datasource/local/local_database.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/notification_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/recurrence_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initializeDependencies() async {
  instance.registerSingleton<LocalDatabase>(LocalDatabase());
  instance.registerSingleton<WorkRespositoryImpl>(WorkRespositoryImpl());
  instance.registerSingleton<NotificationRespositoryImpl>(
      NotificationRespositoryImpl());
  instance.registerSingleton<RecurrenceRespositoryImpl>(
      RecurrenceRespositoryImpl());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('LOAI_CV')) {
    await prefs.setStringList('LOAI_CV', [
      'Không có',
      'Công việc',
      'Sinh nhật',
      'Học tập',
      'Việc cần làm',
      'Cuộc họp',
      'Sở thích',
      'Thói quen'
    ]);
  }
}
