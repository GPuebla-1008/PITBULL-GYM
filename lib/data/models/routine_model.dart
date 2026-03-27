class Routine {
  final String id;
  final String tenantId;
  final String name;
  final String description;
  final List<String> exercises;
  final DateTime createdAt;

  Routine({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.description,
    required this.exercises,
    required this.createdAt,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      exercises: List<String>.from(json['exercises'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenant_id': tenantId,
      'name': name,
      'description': description,
      'exercises': exercises,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
