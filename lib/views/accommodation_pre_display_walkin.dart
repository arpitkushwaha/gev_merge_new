import 'package:flutter/material.dart';
import 'package:gev_app/controllers/accommodation_controller.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/views/accomodationWalkIn.dart';

class AccommodationPreDisplayWalkIn extends StatefulWidget {
  @override
  _AccommodationPreDisplayWalkInState createState() =>
      _AccommodationPreDisplayWalkInState();
}

class _AccommodationPreDisplayWalkInState
    extends State<AccommodationPreDisplayWalkIn> {
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
        title: Text("Location"),
      ),
      body: Center(
        child: FutureBuilder<List<MobileAccomodationDetails>>(
          future: accomodationdetailslist,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new AccommodatationWalkIn(
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
