import 'package:flutter/material.dart';

class HomeSection2 extends StatefulWidget {
  @override
  _HomeSection2State createState() => _HomeSection2State();
}

class _HomeSection2State extends State<HomeSection2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gev.jpg"),
          colorFilter: ColorFilter.srgbToLinearGamma(),
          fit: BoxFit.cover,
        ),
      ),
      //intro video about Gev
      // child:VideoPlayerr()
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: Text(
              'About GEV',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Gev is one of the best place to medidate and have peace. You can visit various temples and then decide to get yourself involved in the holy spirit.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
