class EventWithId {
  String userId;
  int created_ts;
  String title;

  EventWithId(
      {required this.userId, required this.created_ts, required this.title});

  // Factory constructor for creating a new Event instance from a map
  factory EventWithId.fromJson(Map<String, dynamic> json) {
    return EventWithId(
        userId: json['userId'] as String,
        created_ts: json['created_ts'] as int,
        title: json['title'] as String);
  }
}
