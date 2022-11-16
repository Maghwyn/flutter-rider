import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvConfiguration {
  final String mongoUri;
  final String mongoDbName;

  DotEnvConfiguration({
    required this.mongoUri,
    required this.mongoDbName,
  });
}

final env = DotEnvConfiguration(
  mongoUri: dotenv.get('MONGO_URI', fallback: 'mongodb://flutteruser:4z3ZqFb0jtdXC8dLhZU14J6V8LpjYyfWni1Ujsj0@localhost:27017'), 
  mongoDbName: dotenv.get('MONGO_DBNAME', fallback: 'flutter-test'),
);
