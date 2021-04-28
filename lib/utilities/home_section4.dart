import 'package:flutter/material.dart';
import 'package:gev_app/controllers/schedule_controller.dart';
import 'package:gev_app/models/schedule_list_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSection4 extends StatefulWidget {
  @override
  _HomeSection4State createState() => _HomeSection4State();
}

class _HomeSection4State extends State<HomeSection4> {
  ScheduleController scheduleController = ScheduleController();
  List<ScheduleListModel> templeList;
  @override
  void initState() {
    super.initState();
    setState(() {
      templeList = scheduleController.getTempleList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schedule',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See More'),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
          child: widgetSlider(context),
        ),
      ],
    );
  }

  Swiper widgetSlider(context) {
    return new Swiper(
      autoplay: true,
      viewportFraction: 0.8,
      scale: 1,
      itemCount: scheduleController.getTempleList().length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 0, right: 40),
          child: InkWell(
            onTap: () {
              showAlertBox(context, index);
            },
            child: Container(
              height: 50,
              width: 10,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.99), BlendMode.dstATop),
                  image: AssetImage(templeList[index].imageUrl),
                ),
              ),
              child: Center(
                child: Text(
                  '${templeList[index].name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AlertDialog showAlertBox(BuildContext context, int index) {
    var alertBox = AlertDialog(
      title: Text(
        'Name : ${templeList[index].name}',
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Time: ${templeList[index].time}'),
            SizedBox(
              height: 2,
            ),
            Text('Description: ${templeList[index].description}'),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertBox;
        });
  }
}
