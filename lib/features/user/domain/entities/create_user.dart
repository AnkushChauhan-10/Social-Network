import 'package:equatable/equatable.dart';

class CreateUser extends Equatable {
  const CreateUser({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
  });

  final String id;
  final String name;
  final String userName;
  final String email;

  @override
  List<Object?> get props => [];
}
