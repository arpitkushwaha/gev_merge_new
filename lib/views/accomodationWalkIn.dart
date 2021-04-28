import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/controllers/accommodation_controller.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';

import 'accommodationWalkIncard.dart';

class AccommodatationWalkIn extends StatefulWidget {
  final List<MobileAccomodationDetails> accomodationdetailslist;
  const AccommodatationWalkIn({Key key, this.accomodationdetailslist})
      : super(key: key);
  @override
  _AccommodatationWalkInState createState() => _AccommodatationWalkInState();
}

class _AccommodatationWalkInState extends State<AccommodatationWalkIn> {
  int currentIndex = 0;
  List<Widget> cardList = [];
  List<MobileAccomodationDetails> accomodationdetailslist;
  AccommodationController accommodationController =
      new AccommodationController();
  // List<MobileAccomodationDetails> accomodationdetailslist;
  @override
  void initState() {
    super.initState();
    this.accomodationdetailslist = widget.accomodationdetailslist;
    cardList = getLocationCards(accomodationdetailslist);
  }

  // Get all the list of locations from the location controller.
  List<Widget> getLocationCards(
      List<MobileAccomodationDetails> accomodationdetailslist) {
    List<AccommodationWalkInCard> accocardlist = [];
    print('print me' + accomodationdetailslist.length.toString());
    for (var i = 0; i < accomodationdetailslist.length; i++) {
      accocardlist.add(
          new AccommodationWalkInCard(accodetails: accomodationdetailslist[i]));
      print(accocardlist);
    }
    return accocardlist;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/background_image.jpg",
            fit: BoxFit.fill,
          ),
          GestureDetector(
            child: CarouselSlider(
              options: CarouselOptions(
                height: SizeConfig.blockSizeVertical * 40,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 2),
                enlargeCenterPage: false,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                scrollDirection: Axis.vertical,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                    print(index);
                  });
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
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LocationDetails(
              //             locdetails: locdetailslist[_currentIndex])));
            },
          ),
        ],
      ),
    );
  }
}
