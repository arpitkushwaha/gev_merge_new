import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gev_app/controllers/accommodation_controller.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/views/accommodation_map_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'accommodation_detail.dart';

class AccommodationMapDisplayCheckIN extends StatefulWidget {
  final List<MobileAccomodationDetails> accomodationdetailslist;
  const AccommodationMapDisplayCheckIN({Key key, this.accomodationdetailslist})
      : super(key: key);
  @override
  _AccommodationMapDisplayCheckINState createState() =>
      _AccommodationMapDisplayCheckINState();
}

class _AccommodationMapDisplayCheckINState
    extends State<AccommodationMapDisplayCheckIN> {
  List<MobileAccomodationDetails> accomodationdetailslist;
  int _currentIndex = 0;
  List<Widget> cardList = [];
  List<Marker> markerList = [];
  Set<Marker> _marker = {};
  static CameraPosition _initialMaplocation;
  AccommodationController accommodationController =
      new AccommodationController();
  // List<MobileAccomodationDetails> accomodationdetailslist;
  double bottampaddingofMap = 0;
  Completer<GoogleMapController> _controllergooglemap = Completer();
  GoogleMapController newGoogleMapcontroller;
  GlobalKey<ScaffoldState> scaffolkey = new GlobalKey<ScaffoldState>();
  Position currentlocation;
  var geoLocator = Geolocator();
  LatLng latLatPosition;
  BitmapDescriptor customIcon;
  @override
  void initState() {
    setCustomeMarker();
    super.initState();
    // accomodationdetailslist = accommodationController.getAccommdationList();
    this.accomodationdetailslist = widget.accomodationdetailslist;

    cardList = getLocationCards(accomodationdetailslist);
    markerList = getLocationMarkers(accomodationdetailslist);
    _marker = markerList.toSet();
    _initialMaplocation = CameraPosition(
        target: LatLng(double.parse(accomodationdetailslist[0].latitude),
            double.parse(accomodationdetailslist[0].longtitude)),
        zoom: 15);
    print('print me' + cardList.length.toString());
  }

  // Get all the list of locations and set Markers list .
  List<Marker> getLocationMarkers(
      List<MobileAccomodationDetails> accomodationdetailslist) {
    List<Marker> markerList = [];
    for (var i = 0; i < accomodationdetailslist.length; i++) {
      markerList.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(accomodationdetailslist[i].latitude),
              double.parse(accomodationdetailslist[i].longtitude)),
          icon: customIcon,
          infoWindow: InfoWindow(
            title: accomodationdetailslist[i].name,
            snippet: accomodationdetailslist[i].description,
            onTap: () {},
          )));
    }
    return markerList;
  }

// Get all the list of locations from the location controller.
  List<Widget> getLocationCards(
      List<MobileAccomodationDetails> accomodationdetailslist) {
    List<AccommodationCard> accocardlist = [];
    print('print me' + accomodationdetailslist.length.toString());
    for (var i = 0; i < accomodationdetailslist.length; i++) {
      accocardlist
          .add(new AccommodationCard(accodetails: accomodationdetailslist[i]));
      print(accocardlist);
    }
    return accocardlist;
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

  // create a position to locate on map
  void getPostion(int index,
      List<MobileAccomodationDetails> accomodationdetailslist) async {
    latLatPosition = LatLng(
        double.parse(accomodationdetailslist[index].latitude),
        double.parse(accomodationdetailslist[index].longtitude));
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: SizeConfig.blockSizeVertical * 32,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 1.7,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        print(index);
                      });
                    },
                    onScrolled: (value) {
                      getPostion(_currentIndex, accomodationdetailslist);
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccommodationDetail(
                              accodetails:
                                  accomodationdetailslist[_currentIndex])));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
