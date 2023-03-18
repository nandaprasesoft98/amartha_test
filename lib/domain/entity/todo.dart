import 'package:equatable/equatable.dart';

class Todo with EquatableMixin {
  final String id;
  final String description;
  final bool isMarked;

  Todo({
    required this.id,
    required this.description,
    required this.isMarked
  });

  Todo copy({
    String? id,
    String? description,
    bool? isMarked
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isMarked: isMarked ?? this.isMarked
    );
  }

  @override
  List<Object?> get props => [id, description, isMarked];
}