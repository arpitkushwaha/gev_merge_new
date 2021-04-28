import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';

class AccommodationWalkInCard extends StatefulWidget {
  final MobileAccomodationDetails accodetails;
  const AccommodationWalkInCard({Key key, this.accodetails}) : super(key: key);
  @override
  _AccommodationWalkInCardState createState() =>
      _AccommodationWalkInCardState();
}

class _AccommodationWalkInCardState extends State<AccommodationWalkInCard> {
  MobileAccomodationDetails accodetails;
  @override
  void initState() {
    super.initState();
    this.accodetails = widget.accodetails;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
              child: Image.network(
                '${accodetails.imageName}',
                // width: 300.0,
                width: SizeConfig.blockSizeHorizontal * 98,
                height: SizeConfig.blockSizeVertical * 50,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 8,
              width: SizeConfig.screenWidth,
              color: Colors.orange,
              child: Center(
                child: Text(
                  accodetails.description,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
