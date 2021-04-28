import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';
import 'package:gev_app/utilities/commons.dart';
import 'package:gev_app/views/accommodation_map_predisplay.dart';

class AccommodationDetail extends StatefulWidget {
  final MobileAccomodationDetails accodetails;
  const AccommodationDetail({Key key, this.accodetails}) : super(key: key);
  @override
  _AccommodationDetailState createState() => _AccommodationDetailState();
}

class _AccommodationDetailState extends State<AccommodationDetail> {
  MobileAccomodationDetails accodetails;
  int currentIndex = 0;
  List<Widget> cardList = [];
  @override
  void initState() {
    super.initState();

    this.accodetails = widget.accodetails;
    cardList = getImageCardsList(accodetails);
    print('print me' + cardList.length.toString());
  }

  List<Widget> getImageCardsList(MobileAccomodationDetails accodetails) {
    List<Widget> imageCardList = [];
    for (var i = 0; i < accodetails.images.length; i++) {
      // print(accodetails.images[i]);
      imageCardList.add(createImagesCards(accodetails.images[i].toString()));
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
          accodetails.name,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          // onPressed: () => Navigator.of(context).pop(),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AccommodationMapPredisplay()));
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
                                text: "\n${accodetails.description}",
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
                      currentIndex = index;
                    });
                  },
                ),
                items: cardList.map((card) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      // height: MediaQuery.of(context).size.height * 0.50,
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
