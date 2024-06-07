class Event {
  String userId;
  String title;
  String? eventId;
  DateTime? date;
  Event({required this.userId, required this.title, this.eventId, this.date});
  // Factory constructor for creating a new Event instance from a map
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        userId: json['userId'] as String,
        title: json['title'] as String,
        eventId: json['eventId'] as String,
        date: json['date' as DateTime]);
  }

  // Factory constructor to create Event from a map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        userId: map['userId'] as String,
        title: map['title'] as String,
        // eventId: map['eventId'] as String,
        date: DateTime.parse(map['date']));
  }
}
