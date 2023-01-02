class LiveStreamModel {
  final String title;
  final String image;
  final String uid;
  final String username;
  final startedAt;
  final int viewers;
  final String channelId;

  LiveStreamModel({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.viewers,
    required this.channelId,
    required this.startedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'uid': uid});
    result.addAll({'username': username});
    result.addAll({'viewers': viewers});
    result.addAll({'channelId': channelId});
    result.addAll({'startedAt': startedAt});

    return result;
  }

  factory LiveStreamModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      viewers: map['viewers']?.toInt() ?? 0,
      channelId: map['channelId'] ?? '',
      startedAt: map['startedAt'] ?? '',
    );
  }
}
