class ApiEndPoint {
  //BASEURL
  static const String baseUrl = "https://sukhprasavam.shebirth.com";
  // LOGIN-
  static const String login = "$baseUrl/login/";
  static const String login_data = '$baseUrl/login-user-data/';
  // FORGOT PASSWORD
  static const String forgot_password = '$baseUrl/api/password_reset/';
}

//********************************************************************************//

class Admin {
  //BASEURL
  static const String baseUrl = "https://sukhprasavam.shebirth.com";
  //DISPLAY
  static const String display = '$baseUrl/admin-panel/admin-dashboard-details/';
  //INTERNAL USER
  static const String sales = '$baseUrl/admin-panel/all-salesTeam-list/';
  static const String consultant = '$baseUrl/admin-panel/all-consultants-list/';
//EXTERNAL USER
  static const String all_doctor = '$baseUrl/admin-panel/all-doctors-list/';
  static const String approve_doctor =
      '$baseUrl/admin-panel/doctor-approval-requests/';
  static const String hospital = '$baseUrl/admin-panel/all-hospitals/';
//ACCOUNT STATUS
  static const String account_status = '$baseUrl/activateOrDeactivate/';
  //DETAILS
  static const String details = '$baseUrl/doctor/doctor-profile/';
//SUBSCRIPTION
  static const String subscription = '$baseUrl/admin-panel/subscriptions-tab/';
//REGISTRATION
  static const String addnew_consultant = '$baseUrl/consultant-registration/';
  static const String addnew_hospital = '$baseUrl/hospital-registration/';
  static const String addnew_sales = '$baseUrl/sales-registration/';
//CLIENT PROFILE
  static const String client_profile = '$baseUrl/customer-profile/';
//TRACKER
  static const String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static const String medicine_get = '$baseUrl/customer/medicine-GET/';
  static const String customized_diet =
      '$baseUrl/consultant/add-customized-plan/';
  static const String exercise_get = '$baseUrl/customer/exercise-get/';
  static const String medical_get = '$baseUrl/customer/get-medical/';
  static const String contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static const String symptom_get = '$baseUrl/customer/Symptoms-GET/';
  static const String activity_get = '$baseUrl/customer/get-activity-tasks/';
  //ALL CLIENT LIST
  static const String all_client = '$baseUrl/admin-panel/all-clients-list/';
//UPDATE TRACKER
  static const String update_tracker_post =
      '$baseUrl/customer/add-acivity-excersice-modules/';
//LEARNING MODULE
  static const String add_vedio = '$baseUrl/learning/add-videos/';
//EDIT DAILYTRACKER
  static const String edit_activity_tracker =
      '$baseUrl/admin-panel/all-activity-main-modules-per-stage/';
  static const String edit_exercise_tracker =
      '$baseUrl/admin-panel/all-excercises-per-stage/';
  static const String edit_exercise_post =
      '$baseUrl/admin-panel/edit-exercise/';
//TOGGLE
  static const String toggle_exercise = '$baseUrl/admin-panel/toggle-exercise/';
  static const String toggle_activity =
      '$baseUrl/admin-panel/toggle-activity-main-module/';
//EDIT TRACKER NAME
  static const String edit_exercise_patch= '$baseUrl/admin-panel/edit-exercise/';
  static const String edit_activity_patch= '$baseUrl/admin-panel/edit-activity-main-module/';
//Doctor
  static const String get_doctor = '$baseUrl/doctor/get-doctors/';
  static const String get_doctor_appointment =
      '$baseUrl/doctor/get-doctor-appointments/';
  //EDIT CLIENT PROFILE
static const String edit_client_profile = '$baseUrl/profile-update/';
}

//********************************************************************************//

class Sales {
  //BASEURL
  static const String baseUrl = "https://sukhprasavam.shebirth.com";
  //DISPLAY
  static const String sales_display = '$baseUrl/sales/sales-dashboard-details/';
  //MESSAGE
  static const String chat = '$baseUrl/messages/get-all-clients/';
  //NO UPDATE FROM CLIENT
  static const String no_update = '$baseUrl/sales/no-update-clients/';
//CLIENT THIS MONTH
  static const String client_this_month = '$baseUrl/sales/client-this-month/';
//TRACKERS
  static const String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static const String medicine_get = '$baseUrl/customer/medicine-GET/';
  static const String customized_diet =
      '$baseUrl/consultant/add-customized-plan/';
  static const String exercise_get = '$baseUrl/customer/exercise-get/';
  static const String medical_get = '$baseUrl/customer/get-medical/';
  static const String contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static const String symptom_get = '$baseUrl/customer/Symptoms-GET/';
  static const String activity_get_data =
      '$baseUrl/customer/get-activity-tasks/';
  //MESSAGE
  static const String all_client = '$baseUrl/messages/get-all-clients/';
  static const String get_message = '$baseUrl/messages/get-all-messages/';
  static const String send_message = '$baseUrl/messages/send-message/';
  //UPDATE_TRACKER
  static const String update_diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static const String update_diet_post =
      '$baseUrl/customer/diet-tracker-add-POST/';
  static const String update_medicine_get = '$baseUrl/customer/medicine-GET/';
  static const String update_medicine_post =
      "$baseUrl/customer/medicine-update/";
  static const String update_exercise_get = '$baseUrl/customer/exercise-get/';
  static const String update_exercise_post =
      '$baseUrl/customer/exercise-submit/';
  static const String update_custom_exercise_post =
      '$baseUrl/customer/custom-exercise-submit/';
  static const String update_calories_post =
      '$baseUrl/customer/calories-burnt-add/';
  static const String update_activity_get =
      '$baseUrl/customer/get-activity-tasks/';
  static const String update_activity_predefined_post =
      '$baseUrl/customer/submit-activity/';
  static const String update_activity_custom_post =
      '$baseUrl/customer/submit-custom-activity/';
  static const String update_symptoms_get = "$baseUrl/customer/Symptoms-GET/";
  static const String update_symptoms_predefined_post =
      '$baseUrl/customer/symptoms-submit/';
  static const String update_symptoms_custom_post =
      "$baseUrl/customer/submit-custom-symptom/";
  static const String update_medical_get =
      '$baseUrl/customer/get-medical-form-data/';
  static const String update_medical_post = '$baseUrl/customer/medical-ADD/';
  static const String update_contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static const String update_contraction_post =
      '$baseUrl/customer/contraction/';
  // ANALYSIS
  static const String symptoms_analysis =
      '$baseUrl/analytics/get-symptom-analysis/';
  static const String medical_analysis =
      '$baseUrl/analytics/get-medical-analysis/';
  static const String analysis = '$baseUrl/analytics/client-criticalities/';
  // INITIAL FLOW UP
  static const String flowup_medical_get =
      '$baseUrl/analytics/get-medical-data/';
  static const String flowup_medical_post =
      '$baseUrl/analytics/post-medical-data/';
  static const String personal_detail_get =
      '$baseUrl/analytics/get-personal-details/';
  static const String personal_details_post =
      '$baseUrl/analytics/submit-personal-details/';
// CALL REOCRD
  static const String callRecord_get = '$baseUrl/get-call-response/';
  static const String callRecord_post = '$baseUrl/sales/call-response/';
//CLIENT PROFILE
  static const String clients_profile = '$baseUrl/customer-profile';
//DOCTOR
  static const String get_doctor = '$baseUrl/doctor/get-doctors/';
  static const String get_doctor_appointment =
      '$baseUrl/doctor/get-doctor-appointments/20/?sort_by=upcoming';
  //INVESTIGATION REPORT
  static const String investigation_report =
      '$baseUrl/sales/investigation-report/';
  //OTHER SYMPTOMS
  static const String other_symptoms = '$baseUrl/admin-panel/get-critical-symptoms/';
  static const String other_symptoms_post = '$baseUrl/admin-panel/submit-critical-symptom/';
}
