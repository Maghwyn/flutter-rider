import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/models/user.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

setupDatabaseLocator(DBConnection mongodb) {
  inject.registerSingleton<DBConnection>(mongodb);
}

setupLoggedUserLocator(User user) {
  inject.registerSingleton<User>(user);
}

unregisterLoggedUserLocator() {
  if (inject.isRegistered<User>()) {
    inject.unregister<User>();
  }
}
