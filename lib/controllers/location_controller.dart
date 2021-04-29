import 'package:gev_app/models/MobileLocationDetails.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class LocationController {
  Future<List<MobileLocationDetails>> fetchLocationList() async {
    List<MobileLocationDetails> locationlist;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response = await wsm.makeGetRequest('fetch-location');
    locationlist = List<MobileLocationDetails>.from(response["location_details"]
        .map((json) => MobileLocationDetails.fromJson(json)));
    return locationlist;
  }
}
