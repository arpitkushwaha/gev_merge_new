class MobileLocationDetails {
  int id;
  String name;
  String description;
  String imageName;
  String locationType;
  int isLocationAccessOnlyForCheckinUsers;
  String latitude;
  String longtitude;
  int isActive;
  List<String> images;
  // var created_date;
  // var created_by;
  // var last_modified_date;
  // var last_modified_by;
  MobileLocationDetails(
      {this.id,
      this.name,
      this.description,
      this.imageName,
      this.locationType,
      this.isLocationAccessOnlyForCheckinUsers,
      this.latitude,
      this.longtitude,
      this.isActive,
      this.images});

  factory MobileLocationDetails.fromJson(Map<String, dynamic> json) {
    var list = json['location_media'] as List;
    // print(list.runtimeType);
    // print(" --" + list.toString());

    List<String> imagesList =
        list.map((i) => i['media_name'].toString()).toList();
    // List<String>.from(list.map((i) {
    //   print(" --" + i['media_name'].toString());
    //   ImagesJsonMap.fromJson(i['media_name'].toString());
    // }));
    // print('imagesList' + imagesList.toString());

    return MobileLocationDetails(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageName: json['image_name'],
        locationType: json['location_type'],
        latitude: json['latitude'],
        longtitude: json['longtitude'],
        isLocationAccessOnlyForCheckinUsers:
            json['is_location_access_only_for_checkin_users'],
        isActive: json['is_active'],
        images: imagesList);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_name': imageName,
        'location_type': locationType,
        'latitude': latitude,
        'longtitude': longtitude,
        'is_active': isActive,
      };
}

// class ImagesJsonMap {
//   String image;
//   ImagesJsonMap({this.image});

//   factory ImagesJsonMap.fromJson(String json) {
//     return ImagesJsonMap(image: json);
//   }

//   Map<String, dynamic> toJson() => {
//         'media_name': image,
//       };
// }
