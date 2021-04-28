class Constant {
  static const int appBarBackgroundColor = 0xffffffff;
  static const int appBarTextColor = 0xff000000;
  static const int buttonColor = 0xffa55705;
  static const int starColor = 0xffffd660;

  //Db Structure table name

  static String mobileUserFeedback = 'mobile_user_feedback';
  static String mobileUserDetails = 'mobile_user_details';

  //db queries
  static String queryToCreateMobileUserFeedbackTable =
      'CREATE TABLE mobile_user_feedback('
      'id int,'
      'user_id	int,'
      'mobile_user_details_id	int,'
      'created_date	varchar,'
      'created_by	varchar,'
      'overall_experience	int,'
      'reservation_experience	int,'
      'staff_efficiency	int,'
      'events_organisation	int,'
      'value_of_experience	int,'
      'overall_comments	varchar,'
      'is_selected_for_display	boolean)';

  static String queryToCreateMobileUserDetailsTable =
      'CREATE TABLE mobile_user_details('
      'id	INTEGER PRIMARY KEY,'
      'user_id	int,'
      'visit_type	varchar,'
      'check_in_date	date,'
      'check_out_date	date,'
      'check_in_code	varchar,'
      'additional_member	int,'
      'create_date	varchar,'
      'created_by	varchar,'
      'last_modified_date	varchar,'
      'last_modified_by	varchar,'
      'device_name	varchar,'
      'device_id	varchar,'
      'Slot_time_start	varchar,'
      'Slot_time_end	varchar'
      ')';

  static String queryToGetAllRecordsOfMobileUserDetailsTable =
      "SELECT * FROM mobile_user_details";
}
