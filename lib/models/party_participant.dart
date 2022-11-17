import 'package:mongo_dart/mongo_dart.dart';

class PartyParticipant {
  final ObjectId? id;
  final ObjectId? userId;
  final ObjectId? partyId;
  final String comment;
  final DateTime? createdAt;
  final String? picture;

  PartyParticipant({
    this.id,
    this.userId,
    this.partyId,
    required this.comment,
    this.createdAt,
    this.picture,
  });
}