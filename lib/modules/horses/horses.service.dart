import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/horse.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ModifierBuilder, ObjectId, WriteResult, where;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class HorsesServiceTemplate extends GetxService {
  Future<RxList<Horse>> getHorses();
  Future<Horse> addHorse(Horse horse);
  Future<Horse> editHorse(Horse horse);
  Future<bool> deleteHorse(Horse horse);
  Future<Horse> _getHorse();
}

class HorsesService extends HorsesServiceTemplate {
  final DbCollection _horses = inject<DBConnection>().getCollection("horses");
  final User _user = inject<User>();

  @override
  Future<RxList<Horse>> getHorses() async {
    final horseDocuments = await _horses.find().toList();
    late RxList<Horse> horses = RxList<Horse>();

    for(var n = 0; n < horseDocuments.length; n++) {
      var horse = horseDocuments[n];

      horses.add(Horse(
        id: horse["_id"],
        userId: horse["userId"],
        name: horse["name"],
        age: horse["age"],
        picture: horse["picture"],
        createdAt: horse["createdAt"],
        robe: horse["robe"],
        race: horse["race"],
        sexe: horse["sexe"],
      ));
    }

    return horses;
  }

  @override
  Future<Horse> addHorse(Horse horse) async {
    WriteResult mongoDocument = await _horses.insertOne({
      "userId": _user.id,
      "name": horse.name,
      "age": horse.age,
      "createdAt": DateTime.now(),
      "picture": horse.picture,
      "robe": horse.robe,
      "race": horse.race,
      "sexe": horse.sexe,
    });

    final mongoHorse = mongoDocument.document;
    return Horse(
      id: mongoDocument.id as ObjectId,
      userId: mongoHorse!["userId"] as ObjectId,
      name: mongoHorse["name"] as String,
      age: mongoHorse["age"] as String,
      robe: mongoHorse["robe"] as String,
      picture: mongoHorse["picture"] as String,
      createdAt: mongoHorse["createdAt"] as DateTime,
      race: mongoHorse["race"] as String,
      sexe: mongoHorse["sexe"] as String,
    );
  }

  // 6377501716a74deeb121a2ed

  @override
  Future<bool> deleteHorse(Horse horse) async {
    // // TODO: implement deleteCourse
    // throw UnimplementedError();

    return true;
  }

  @override
  Future<Horse> _getHorse() async {
    final horse = await _horses.findOne({"_id": "6377501716a74deeb121a2ed"});

    return Horse(
      id: horse!["_id"] as ObjectId,
      userId: horse["userId"] as ObjectId,
      name: horse["name"] as String,
      age: horse["age"] as String,
      robe: horse["robe"] as String,
      picture: horse["picture"] as String,
      createdAt: horse["createdAt"] as DateTime,
      race: horse["race"] as String,
      sexe: horse["sexe"] as String,
    );
  }

  @override
  Future<Horse> editHorse(Horse horse) async {
    await _horses.updateOne(
      where.eq("_id", _user.id),
      ModifierBuilder()
        .set("name", horse.name)
        .set("picture", horse.picture)
        .set("age", horse.age)
        .set("robe", horse.robe)
        .set("race", horse.race)
        .set("sexe", horse.sexe)
    );

    return await _getHorse();
  }
}