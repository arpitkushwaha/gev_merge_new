import 'package:gev_app/models/feedback.dart';
import 'package:gev_app/models/feedback_list_model.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/db_manager.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class FeedbackController {
  // List to get the feedbacks for the item builder (home screen).
  Future<List<FeedbackListModel>> fetchFeedbackList() async {
    List<FeedbackListModel> feedbackList;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response =
        await wsm.makeGetRequest('fetch-user-feedback');
    print('response' + response.toString());
    feedbackList = List<FeedbackListModel>.from(
        response['feedback'].map((json) => FeedbackListModel.fromJson(json)));
    print('feedbackList list controller: ' + feedbackList[1].name.toString());
    return feedbackList;
  }

  // List<FeedbackListModel> getFeedbackList() {
  //   List<FeedbackListModel> feedbackList = [
  //     FeedbackListModel(
  //       name: 'Raman',
  //       text: 'Here is the text',
  //       rating: 4.0,
  //     ),
  //     FeedbackListModel(
  //       name: 'Rohan',
  //       text: 'Here is the text',
  //       rating: 4.0,
  //     ),
  //     FeedbackListModel(
  //       name: 'Raman',
  //       text: 'Here is the text',
  //       rating: 4.0,
  //     ),
  //     FeedbackListModel(
  //       name: 'Raman',
  //       text: 'Here is the text',
  //       rating: 4.0,
  //     ),
  //   ];
  //   return feedbackList;
  // }

  // List to get the feedbacks for the item builder (feedback screen).
  List<FeedbackListModel> getViewDetailsList() {
    List<FeedbackListModel> viewDetailsList = [
      FeedbackListModel(text: "Overall Experience", rating: 3.0),
      FeedbackListModel(text: "Reservation Experience", rating: 3.0),
      FeedbackListModel(text: "Staff Experience", rating: 3.0),
      FeedbackListModel(text: "Events Organization", rating: 3.0),
      FeedbackListModel(text: "Value For Money", rating: 3.0),
    ];

    print("getFeedbackList() : ${viewDetailsList[0].text}");
    return viewDetailsList;
  }

  //Function for storing data in database.

  void saveDataToDB(FeedbackModel feedbackModel) {
    DbManager db = DbManager();
    db.createTableIfNotExists(Constant.mobileUserFeedback,
        Constant.queryToCreateMobileUserFeedbackTable);
    db.insert(Constant.mobileUserFeedback, feedbackModel.toJson());
  }
}
