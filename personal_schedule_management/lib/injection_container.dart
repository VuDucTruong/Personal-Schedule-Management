import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/datasource/local/local_database.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/invitation_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/report_responsitory_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/user_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/features/controller/data_source_controller.dart';
import 'package:personal_schedule_management/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initializeDependencies() async {
  instance.registerSingleton<WorkRespositoryImpl>(WorkRespositoryImpl());
  instance.registerSingleton<ReportResponsitoryImpl>(ReportResponsitoryImpl());
  instance.registerSingleton<UserRespositoryImpl>(UserRespositoryImpl());
  instance.registerSingleton<NotificationServices>(NotificationServices());
  instance.registerSingleton<DataSourceController>(DataSourceController());
  instance.registerSingleton<InvitationRespositoryImpl>(
      InvitationRespositoryImpl());
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
  if (!prefs.containsKey(BAN_ACCOUNT)) {
    prefs.setStringList(BAN_ACCOUNT, []);
  }
}
