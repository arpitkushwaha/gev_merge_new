class MobileAccomodationDetails {
  int id;
  var name;
  var description;
  var imageName;
  var latitude;
  var longtitude;
  int isActive;
  List<String> images;

  MobileAccomodationDetails(
      {this.id,
      this.name,
      this.description,
      this.imageName,
      this.latitude,
      this.longtitude,
      this.isActive,
      this.images});

  factory MobileAccomodationDetails.fromJson(Map<String, dynamic> json) {
    var list = json['accommodation_media'] as List;
    List<String> imagesList =
        list.map((i) => i['media_name'].toString()).toList();
    // List<String> imagesList = List<String>.from(list.map((i) {
    //   ImagesJsonMap.fromJson(i).toString();
    // }));

    return MobileAccomodationDetails(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageName: json['image_name'],
        latitude: json['latitude'],
        longtitude: json['longtitude'],
        isActive: json['is_active'],
        images: imagesList);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_name': imageName,
        'latitude': latitude,
        'longtitude': longtitude,
        'is_active': isActive,
      };
}

// class ImagesJsonMap {
//   String image;
//   ImagesJsonMap.fromJson(Map<String, dynamic> json)
//       : image = json['media_name'];

//   Map<String, dynamic> toJson() => {
//         'media_name': image,
//       };
// }
