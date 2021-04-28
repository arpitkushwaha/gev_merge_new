import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class AccommodationController {
  Future<List<MobileAccomodationDetails>> fetchAccommodationList() async {
    List<MobileAccomodationDetails> accommdationlist;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makeGetRequest('fetch-accommodation');
    accommdationlist = List<MobileAccomodationDetails>.from(response["accommodation"]
        .map((json) => MobileAccomodationDetails.fromJson(json)));
    print('accomo list controller: ' + accommdationlist[1].name.toString());
    return accommdationlist;
  }
  // List<MobileAccomodationDetails> getAccommdationList() {
  //   List<MobileAccomodationDetails> accommdationlist = [
  //     MobileAccomodationDetails(
  //       id: 1,
  //       name: 'Mahavan Cottages',
  //       description: 'AC rooms',
  //       imageName: 'Sri Radha Vrindavan behari temple',
  //       latitude: '19.6572390851496',
  //       longtitude: '72.9704083260838',
  //       isActive: true,
  //       images: ['assets/images/Img5.jpg', 'assets/images/Img2.jpeg'],
  //     ),
  //     MobileAccomodationDetails(
  //       id: 2,
  //       name: 'Gokul Cottages',
  //       description: 'Single occupancy',
  //       imageName: 'Sri Radha Vrindavan behari temple',
  //       latitude: '19.656707094731',
  //       longtitude: '72.97075456216',
  //       isActive: true,
  //       images: ['assets/images/Img5.jpg', 'assets/images/Img2.jpeg'],
  //     ),
  //     MobileAccomodationDetails(
  //       id: 3,
  //       name: 'Vrindavan Cottages',
  //       description: 'AC Cottages',
  //       imageName: 'Sri Radha Vrindavan behari temple',
  //       latitude: '19.6576316414748',
  //       longtitude: '72.9709982941898',
  //       isActive: true,
  //       images: ['assets/images/Img5.jpg', 'assets/images/Img2.jpeg'],
  //     )
  //   ];
  //   return accommdationlist;
  // }
}
