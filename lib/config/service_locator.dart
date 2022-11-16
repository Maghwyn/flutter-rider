import 'package:flutter_project/config/mongo.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

setupDatabaseLocator(DBConnection mongodb) {
  inject.registerSingleton<DBConnection>(mongodb);
}