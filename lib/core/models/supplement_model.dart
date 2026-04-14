class SupplementItem {
  final String name;
  final String dosage;
  final String
  relativeTiming; // e.g., 'Pre-Entreno', 'Post-Entreno', 'Ayunas', 'Antes de dormir'
  final String description;
  final String icon; // Icon name or category

  SupplementItem({
    required this.name,
    required this.dosage,
    required this.relativeTiming,
    required this.description,
    this.icon = 'medication',
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'relativeTiming': relativeTiming,
      'description': description,
      'icon': icon,
    };
  }

  factory SupplementItem.fromMap(Map<String, dynamic> map) {
    return SupplementItem(
      name: map['name'] ?? '',
      dosage: map['dosage'] ?? '',
      relativeTiming: map['relativeTiming'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? 'medication',
    );
  }
}

class SupplementPlan {
  final String id;
  final String goal; // 'bulk' o 'cut'
  final String userGender; // 'male' o 'female'
  final List<SupplementItem> supplements;
  final DateTime updatedAt;

  SupplementPlan({
    required this.id,
    required this.goal,
    required this.userGender,
    required this.supplements,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'userGender': userGender,
      'supplements': supplements.map((x) => x.toMap()).toList(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SupplementPlan.fromMap(String id, Map<String, dynamic> map) {
    return SupplementPlan(
      id: id,
      goal: map['goal'] ?? 'bulk',
      userGender: map['userGender'] ?? 'male',
      supplements: List<SupplementItem>.from(
        (map['supplements'] as List<dynamic>? ?? []).map(
          (x) => SupplementItem.fromMap(x),
        ),
      ),
      updatedAt: DateTime.parse(
        map['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
