import 'package:equatable/equatable.dart';

class FloraEduUser extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;

  const FloraEduUser(
      {required this.id, this.firstName, this.lastName, this.email});

  @override
  List<Object?> get props => [id];

  static const empty = FloraEduUser(id: '-');
}
