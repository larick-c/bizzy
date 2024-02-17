class Event {
  String title;
  Event({required this.title});

  // Factory constructor for creating a new Event instance from a map
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(title: json['title'] as String);
  }
}
