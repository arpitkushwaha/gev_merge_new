
class EventModel
{
  int id;
  String name ;
  String description ;
  String event_date ;
  String event_start_time ;
  String event_end_time;
  String venue;
  String event_category;
  int is_enabled ;
  String created_at ;
  String updated_at ;
  String created_by;
  String last_updated_by;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.event_date,
    this.event_start_time,
    this.event_end_time,
    this.venue,
    this.event_category,
    this.is_enabled,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.last_updated_by});

  EventModel.fromJson(Map<String, dynamic> json)
      :id=json['id'],
        name=json['name'],
        description=json['description'],
        event_date=json['event_date'],
        event_start_time=json['event_start_time'],
        event_end_time=json['event_end_time'],
        venue=json['venue'],
        event_category=json['event_category'],
        is_enabled=json['is_enabled'],
        created_at=json['created_at'],
        updated_at=json['updated_at'],
        created_by=json['created_by'],
        last_updated_by=json['last_updated_by'];

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name,
    'description':description,
    'event_date':event_date,
    'event_start_time':event_start_time,
    'event_end_time':event_end_time,
    'venue':venue,
    'event_category':event_category,
    'is_enabled':is_enabled,
    'created_at':created_at,
    'updated_at':updated_at,
    'created_by':created_by,
    'last_updated_by':last_updated_by,
  };





}