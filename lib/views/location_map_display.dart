import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/controllers/usertype_controller.dart';
import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/controllers/location_controller.dart';
import 'package:gev_app/views/location_details.dart';
import 'package:gev_app/views/location_map_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gev_app/utilities/size_config.dart';

class LocationMapDisplay extends StatefulWidget {
  final List<MobileLocationDetails> locdetailslist;
  const LocationMapDisplay({Key key, this.locdetailslist}) : super(key: key);
  @override
  _LocationMapDisplayState createState() => _LocationMapDisplayState();
}

class _LocationMapDisplayState extends State<LocationMapDisplay> {
  List<MobileLocationDetails> locdetailslist;
  int _currentIndex = 0;
  List<Widget> cardList = [];
  List<Marker> markerList = [];
  Set<Marker> _marker = {};
  static CameraPosition _initialMaplocation;
  LocationController locController = new LocationController();
  double bottampaddingofMap = 0;
  Completer<GoogleMapController> _controllergooglemap = Completer();
  GoogleMapController newGoogleMapcontroller;
  GlobalKey<ScaffoldState> scaffolkey = new GlobalKey<ScaffoldState>();
  Position currentlocation;
  var geoLocator = Geolocator();
  LatLng latLatPosition;
  BitmapDescriptor customIcon;
  var userType;
  @override
  void initState() {
    setCustomeMarker();
    super.initState();
    userType = UserType().getdata();
    // locationDetailslist = locController.fetchLocationList();
    // print('locationDetailslist view: ' + locationDetailslist.toString());
    // locdetailslist = locController.getLocationList();
    this.locdetailslist = widget.locdetailslist;
    cardList = getLocationCards(locdetailslist);
    markerList = getLocationMarkers(locdetailslist);
    _marker = markerList.toSet();
    _initialMaplocation = CameraPosition(
        target: LatLng(double.parse(locdetailslist[0].latitude),
            double.parse(locdetailslist[0].longtitude)),
        zoom: 15);
    print('print me' + cardList.length.toString());
  }

// Get all the list of locations from the location controller.
  List<Widget> getLocationCards(List<MobileLocationDetails> locdetailslist) {
    List<LocationMapCard> loccardlist = [];
    print('print me' + locdetailslist.length.toString());

    for (MobileLocationDetails mobileLocationDetails in locdetailslist) {
      // mobileLocationDetails.images = [
      //   'assets/images/Img5.jpg',
      //   'assets/images/Img2.jpeg'
      // ];
      // if (mobileLocationDetails.isLocationAccessOnlyForCheckinUsers == 0 &&
      //     userType == "walk-In") {
      print("Names = " + mobileLocationDetails.name);
      loccardlist.add(new LocationMapCard(locdetails: mobileLocationDetails));
      //   continue;
      // }
    }
    return loccardlist;
  }

// this will set custom marker images
  setCustomeMarker() async {
    var mapMaker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/india3.png',
    );
    setState(() {
      this.customIcon = mapMaker;
    });
  }

// Get all the list of locations and set Markers list .
  List<Marker> getLocationMarkers(List<MobileLocationDetails> locdetailslist) {
    List<Marker> markerList = [];
    for (var i = 0; i < locdetailslist.length; i++) {
      markerList.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(locdetailslist[i].latitude),
              double.parse(locdetailslist[i].longtitude)),
          icon: customIcon,
          infoWindow: InfoWindow(
            title: locdetailslist[i].name,
            snippet: locdetailslist[i].description,
            onTap: () {},
          )));
    }
    return markerList;
  }

// create a position to locate on map
  void getPostion(int index, List<MobileLocationDetails> locdetailslist) async {
    latLatPosition = LatLng(double.parse(locdetailslist[index].latitude),
        double.parse(locdetailslist[index].longtitude));
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 18);
    newGoogleMapcontroller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // print(latLatPosition);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottampaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            initialCameraPosition: _initialMaplocation,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            markers: _marker,
            onMapCreated: (GoogleMapController controller) {
              _controllergooglemap.complete(controller);
              newGoogleMapcontroller = controller;
              // locatePostion();
              setState(() {});
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 1.6,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        print(index);
                      });
                    },
                    onScrolled: (value) {
                      getPostion(_currentIndex, locdetailslist);
                    },
                  ),
                  items: cardList.map((card) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        width: SizeConfig.screenWidth,
                        child: Card(
                          elevation: 0.0,
                          child: card,
                        ),
                      );
                    });
                  }).toList(),
                ),
                onTap: () {
                  print('current index' + _currentIndex.toString());
                  print('current index' +
                      locdetailslist[_currentIndex].name.toString());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationDetails(
                              locdetails: locdetailslist[_currentIndex])));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
