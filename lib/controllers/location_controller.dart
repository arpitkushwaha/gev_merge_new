import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class LocationController {
  Future<List<MobileLocationDetails>> fetchLocationList() async {
    List<MobileLocationDetails> locationlist;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makeGetRequest('fetch-location');
    locationlist = List<MobileLocationDetails>.from(response["location_details"]
        .map((json) => MobileLocationDetails.fromJson(json)));
    // print('location list controller: ' + locationlist.images.toString());
    return locationlist;
  }

  // List<MobileLocationDetails> getLocationList() {
  //   List<MobileLocationDetails> locationlist = [
  //     MobileLocationDetails(
  //       id: 1,
  //       name: 'Sri Radha Vrindavan behari temple',
  //       description: 'Sri Radha Vrindavan behari temple',
  //       imageName: 'Sri Radha Vrindavan behari temple',
  //       locationType: 'Temple',
  //       latitude: '19.65591248',
  //       longtitude: '72.96617517',
  //       isActive: 1,
  //       images: ['assets/images/Img5.jpg', 'assets/images/Img2.jpeg'],
  //     ),
  //     MobileLocationDetails(
  //       id: 2,
  //       name: 'Sri Madan Mohan temple',
  //       description: 'Sri Madan Mohan temple',
  //       imageName: 'Sri Madan Mohan temple',
  //       locationType: 'Temple',
  //       latitude: '19.6565187',
  //       longtitude: '72.9666687',
  //       isActive: 1,
  //       images: ['assets/images/temple2.jpg', 'assets/images/temple3.jpg'],
  //     ),
  //     MobileLocationDetails(
  //       id: 3,
  //       name: 'Govardhan Parvat Hill',
  //       description: 'Govardhan Parvat Hill',
  //       imageName: 'Govardhan Parvat Hill',
  //       locationType: 'Temple',
  //       latitude: '19.65602868',
  //       longtitude: '72.96787569',
  //       isActive: 1,
  //       images: ['assets/images/temple1.jpeg', 'assets/images/temple4.jpeg'],
  //     ),
  //     MobileLocationDetails(
  //       id: 4,
  //       name: 'Sr Radha Govind Temple',
  //       description: 'Sr Radha Govind Temple',
  //       imageName: 'Sr Radha Govind Temple',
  //       locationType: 'Temple',
  //       latitude: '19.65527595',
  //       longtitude: '72.96886274',
  //       isActive: 1,
  //       images: ['assets/images/temple1.jpeg', 'assets/images/temple4.jpeg'],
  //     ),
  //   ];
  //   return locationlist;
  // }
}
