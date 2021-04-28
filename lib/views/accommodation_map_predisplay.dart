import 'package:flutter/material.dart';
import 'package:gev_app/controllers/accommodation_controller.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/views/accommodation_map_display_checkIn.dart';

class AccommodationMapPredisplay extends StatefulWidget {
  @override
  _AccommodationMapPredisplayState createState() =>
      _AccommodationMapPredisplayState();
}

class _AccommodationMapPredisplayState
    extends State<AccommodationMapPredisplay> {
  Future<List<MobileAccomodationDetails>> accomodationdetailslist;
  AccommodationController accommodationController =
      new AccommodationController();

  @override
  void initState() {
    super.initState();
    accomodationdetailslist = accommodationController.fetchAccommodationList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Accommodation"),
      ),
      body: Center(
        child: FutureBuilder<List<MobileAccomodationDetails>>(
          future: accomodationdetailslist,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new AccommodationMapDisplayCheckIN(
                    accomodationdetailslist: snapshot.data)
                : Center(child: CircularProgressIndicator());
            // return the ListView widget :
            // Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
    );
  }
}
