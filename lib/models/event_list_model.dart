
class EventListModel {
  int id;
  String eventName;
  String description;
  String eventDate;
  String startTime;
  String endTime;
  String venue;
  String eventCategory;
  int isEnabled;

  EventListModel(
      {this.id,
      this.eventName,
      this.description,
      this.eventDate,
      this.startTime,
      this.endTime,
      this.eventCategory,
      this.venue,
      this.isEnabled});

  factory EventListModel.fromJson(Map<String, dynamic> json) {
    return EventListModel(
      id: json['id'],
      eventName: json['name'],
      description: json['description'],
      eventDate: json['event_date'],
      startTime: json['event_start_time'],
      endTime: json['event_end_time'],
      venue: json['venue'],
      eventCategory: json['event_category'],
      isEnabled: json['rating'],
    );
  }
}
