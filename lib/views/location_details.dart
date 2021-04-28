import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/views/location_map_predisplay.dart';

class LocationDetails extends StatefulWidget {
  final MobileLocationDetails locdetails;
  const LocationDetails({Key key, this.locdetails}) : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  MobileLocationDetails locdetails;
  int _currentIndex;
  List<Widget> cardList = [];

  @override
  void initState() {
    super.initState();
    this.locdetails = widget.locdetails;
    // print(' locdetails print me' + this.locdetails.name.toString());
    cardList = getImageCardsList(locdetails);
  }

  List<Widget> getImageCardsList(MobileLocationDetails locdetails) {
    List<Widget> imageCardList = [];
    print(locdetails.toString());
    for (var i = 0; i < locdetails.images.length; i++) {
      print(locdetails.images[i].toString());
      imageCardList.add(createImagesCards(locdetails.images[i].toString()));
    }
    return imageCardList;
  }

  Widget createImagesCards(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          locdetails.name,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationMapPreDisplay()));
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/hjh.png",
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "\n${locdetails.description}",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12)),
                          ],
                        ),
                      )),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
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
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
    );
  }
}
