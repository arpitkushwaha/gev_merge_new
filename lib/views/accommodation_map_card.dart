import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';

class AccommodationCard extends StatefulWidget {
  final MobileAccomodationDetails accodetails;
  const AccommodationCard({Key key, this.accodetails}) : super(key: key);
  @override
  _AccommodationCardState createState() => _AccommodationCardState();
}

class _AccommodationCardState extends State<AccommodationCard> {
  MobileAccomodationDetails accodetails;
  @override
  void initState() {
    this.accodetails = widget.accodetails;
    super.initState();
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
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 24,
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
