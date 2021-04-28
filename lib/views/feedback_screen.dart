import 'package:flutter/material.dart';
import 'package:gev_app/models/feedback_list_model.dart';
import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/views/support_a_cause_screen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/controllers/feedback_controller.dart';

// Screen to get the feedback of user.
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackController feedbackController;
  List<FeedbackListModel> viewDetailsList;

  @override
  void initState() {
    super.initState();
    feedbackController = FeedbackController();
    viewDetailsList = feedbackController.getViewDetailsList();
  }

  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar('Feedback'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                // height: 250,
                // width: double.infinity,
                child: Image.asset(
                  'assets/images/lord.jpg',
                  width: 500,
                  height: 275,
                  fit: BoxFit.fill,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewDetailsList.length,
                itemBuilder: (context, index) {
                  return Column(

                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [Text(viewDetailsList[index].text)],
                                ),
                                Column(
                                  children: [
                                    SmoothStarRating(
                                        allowHalfRating: true,
                                        onRated: (v) {},
                                        starCount: 5,
                                        rating: viewDetailsList[index].rating,
                                        size: 20.0,
                                        isReadOnly: false,
                                        // fullRatedIconData: Icons.blur_off,
                                        // halfRatedIconData: Icons.blur_on,
                                        color: Color(Constant.starColor),
                                        borderColor: Color(Constant.starColor),
                                        spacing: 0.0)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ButtonTheme(
                          minWidth: 120,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Done');
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(Constant.buttonColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(8.0),
                                  ),
                                  side: BorderSide(
                                      color: Color(Constant.buttonColor))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        ButtonTheme(
                          minWidth: 120,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SupportACause()),
                              );
                            },
                            child: Text(
                              'Support a Cause',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(Constant.buttonColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(8.0),
                                  ),
                                  side: BorderSide(
                                      color: Color(Constant.buttonColor))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
