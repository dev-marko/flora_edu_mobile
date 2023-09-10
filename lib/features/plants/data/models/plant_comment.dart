import 'package:equatable/equatable.dart';

class PlantComment extends Equatable {
  final String id;
  final String plantId;
  final String userId;
  final String userEmail;
  final DateTime createdAt;
  final String content;

  const PlantComment({
    required this.id,
    required this.plantId,
    required this.userId,
    required this.userEmail,
    required this.createdAt,
    required this.content,
  });

  @override
  List<Object?> get props => [id];
}
