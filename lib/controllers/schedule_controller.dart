import 'package:gev_app/models/schedule_list_model.dart';

class ScheduleController {
  // List to get the temples and their details for item builder.
  List<ScheduleListModel> getTempleList() {
    List<ScheduleListModel> scheduleList = [
      ScheduleListModel(
          imageText: "Temple 1",
          imageUrl: "assets/images/temple1.jpeg",
          name: "Kesi Ghat",
          time: "time",
          description: "description"),
      ScheduleListModel(
          imageText: "Temple 2",
          imageUrl: "assets/images/temple3.jpg",
          name: "Madan Mohan",
          time: "time",
          description: "description"),
      ScheduleListModel(
          imageText: "Temple 3",
          imageUrl: "assets/images/temple2.jpg",
          name: "Vrindavan Behari",
          time: "time",
          description: "description"),
      ScheduleListModel(
          imageText: "Temple 4",
          imageUrl: "assets/images/temple4.jpeg",
          name: "Vridavan Forest",
          time: "time",
          description: "description"),
    ];
    return scheduleList;
  }
}
