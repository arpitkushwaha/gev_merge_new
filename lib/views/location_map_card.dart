import 'package:flutter/material.dart';
import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/utilities/size_config.dart';

class LocationMapCard extends StatefulWidget {
  final MobileLocationDetails locdetails;
  const LocationMapCard({Key key, this.locdetails}) : super(key: key);

  @override
  _LocationMapCardState createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<LocationMapCard> {
  MobileLocationDetails locdetails;
  @override
  void initState() {
    super.initState();
    this.locdetails = widget.locdetails;
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
                '${locdetails.imageName}',
                // width: 300.0,
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 20,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 8,
              width: SizeConfig.screenWidth,
              color: Colors.orange,
              child: Center(
                child: Text(
                  locdetails.name,
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
