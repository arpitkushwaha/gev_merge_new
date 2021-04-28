import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/controllers/location_controller.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/views/location_map_display.dart';

class LocationMapPreDisplay extends StatefulWidget {
  @override
  _LocationMapPreDisplayState createState() => _LocationMapPreDisplayState();
}

class _LocationMapPreDisplayState extends State<LocationMapPreDisplay> {
  Future<List<MobileLocationDetails>> locationDetailslist;
  LocationController locController = new LocationController();

  @override
  void initState() {
    super.initState();
    locationDetailslist = locController.fetchLocationList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: FutureBuilder<List<MobileLocationDetails>>(
          future: locationDetailslist,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new LocationMapDisplay(locdetailslist: snapshot.data)
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
