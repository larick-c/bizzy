class Event {
  String title;
  DateTime? eventDate;
  Event({required this.title, this.eventDate});
  // Factory constructor for creating a new Event instance from a map
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        title: json['title'] as String,
        eventDate: json['eventDate' as DateTime]);
  }
}
