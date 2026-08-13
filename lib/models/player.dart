class Player {
  final String id;
  final String name;
  final String email;
  final int coins;
  final int highScore;
  final bool isVerified;

  Player({
    required this.id,
    required this.name,
    required this.email,
    this.coins = 0,
    this.highScore = 0,
    this.isVerified = false,
  });

  Player copyWith({
    String? id,
    String? name,
    String? email,
    int? coins,
    int? highScore,
    bool? isVerified,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      coins: coins ?? this.coins,
      highScore: highScore ?? this.highScore,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'coins': coins,
      'highScore': highScore,
      'isVerified': isVerified,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      coins: map['coins'] ?? 0,
      highScore: map['highScore'] ?? 0,
      isVerified: map['isVerified'] ?? false,
    );
  }
}
