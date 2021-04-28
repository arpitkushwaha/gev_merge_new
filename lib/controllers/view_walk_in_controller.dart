import 'package:gev_app/utilities/constants.dart';
import 'package:gev_app/utilities/db_manager.dart';

class ViewWalkInController {

  //function to get all the records of view walkin screen.
   Future<List<Map>> getDataList() async
  {
    DbManager dbManager = DbManager();
    List<Map> list = await dbManager.getRecords(Constant.queryToGetAllRecordsOfMobileUserDetailsTable);
    return list;
  }

}