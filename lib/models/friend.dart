enum FriendStatus { online, offline }

class Friend {
  final String id;
  final String name;
  final FriendStatus status;
  final int highScore;

  Friend({
    required this.id,
    required this.name,
    this.status = FriendStatus.offline,
    this.highScore = 0,
  });

  Friend copyWith({
    String? id,
    String? name,
    FriendStatus? status,
    int? highScore,
  }) {
    return Friend(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      highScore: highScore ?? this.highScore,
    );
  }
}
