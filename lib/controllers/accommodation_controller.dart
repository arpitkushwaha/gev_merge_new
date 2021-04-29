import 'package:gev_app/models/MobileAccomodationDetails.dart';
import 'package:gev_app/utilities/webservice_manager.dart';

class AccommodationController {
  Future<List<MobileAccomodationDetails>> fetchAccommodationList() async {
    List<MobileAccomodationDetails> accommdationlist;
    WebserviceManager wsm = new WebserviceManager();
    Map<dynamic, dynamic> response =
    await wsm.makeGetRequest('fetch-accommodation');
    accommdationlist = List<MobileAccomodationDetails>.from(
        response["accommodation"]
            .map((json) => MobileAccomodationDetails.fromJson(json)));
    return accommdationlist;
  }
}
