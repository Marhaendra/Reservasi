import 'package:floor/floor.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/login_dao.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [LoginModel])
abstract class AppDatabase extends FloorDatabase {
  LoginDao get loginDao;

  static Future<AppDatabase> getDatabase() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
