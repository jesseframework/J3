import 'dart:io';

import 'package:j3enterprise/src/models/background_job_schedule_model.dart';
import 'package:j3enterprise/src/models/background_jobs_logs_model.dart';
import 'package:j3enterprise/src/models/user_model.dart';
import 'package:j3enterprise/src/models/communication_model.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// import 'dart:io' show Platform;
// import 'dart:io' as io;

part 'moor_database.g.dart';
//part 'Comsset_crud.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
    tables: [Users, Communication, BackgroundJobSchedule, BackgroundJobLogs])
class AppDatabase extends _$AppDatabase {
  static AppDatabase _db = AppDatabase._internal();

  factory AppDatabase() {
    return _db;
  }

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
