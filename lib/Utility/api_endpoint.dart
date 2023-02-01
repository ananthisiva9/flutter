class clientApi {
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";
  //DISPLAY SCREEN
  static final String display = '$baseUrl/customer/customer-dashboard-details/';
  //LEARNING PORTAL
  static final String video = '$baseUrl/learning/get-module-data/';
  static final String add_notes = '$baseUrl/learning/add-notes/';
  //TRACKER
  static final String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static final String diet_post = '$baseUrl/customer/diet-tracker-add-POST/';
  static final String medicine_get = '$baseUrl/customer/medicine-GET/';
  static final String medicine_post = "$baseUrl/customer/medicine-update/";
  static final String exercise_get = '$baseUrl/customer/exercise-get/';
  static final String exercise_post = '$baseUrl/customer/exercise-submit/';
  static final String custom_exercise_post =
      '$baseUrl/customer/custom-exercise-submit/';
  static final String calories_post = '$baseUrl/customer/calories-burnt-add/';
  static final String activity_get = '$baseUrl/customer/get-activity-tasks/';
  static final String activity_predefined_post =
      '$baseUrl/customer/submit-activity/';
  static final String activity_custom_post =
      '$baseUrl/customer/submit-custom-activity/';
  static final String symptoms_get = "$baseUrl/customer/Symptoms-GET/";
  static final String symptoms_predefined_post =
      '$baseUrl/customer/symptoms-submit/';
  static final String symptoms_custom_post =
      "$baseUrl/customer/submit-custom-symptom/";
  static final String medical_get = '$baseUrl/customer/get-medical-form-data/';
  static final String medical_post = '$baseUrl/customer/medical-ADD/';
  static final String contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static final String contraction_post = '$baseUrl/customer/contraction/';
  //ADD NEW TRACKER
  static final String add_medicine_post = '$baseUrl/customer/medicine-POST/';
  static final String add_activity_post =
      '$baseUrl/customer/add-custom-activity/';
  static final String add_symptom_post = '$baseUrl/customer/symptoms-ADD/';
  static final String add_exercise_post =
      '$baseUrl/customer/add-custom-exercise/';
  //APPOINTMENTS
  static final String appoinment_upcoming_get =
      '$baseUrl/appointments/upcoming-appointments/';
  static final String appoinment_completed_get =
      '$baseUrl/appointments/completed-appointment/';
  static final String bookAppoinment_post =
      '$baseUrl/appointments/customer-booking/';
  static final String reshedule_patch =
      '$baseUrl/appointments/reschedule-appointment/';
  //SUMMARY
  static final String summary = '$baseUrl/appointments/get-summary/';
  //PROFILE
  static final String client_profile = '$baseUrl/customer-profile/';
  static final String update_profile = '$baseUrl/profile-update/';
  //DOCTOR PROFILE
  static final String doctor_profile = '$baseUrl/doctor/doctor-filter/';
  //DOCTORS LIST
  static final String all_doctors_list_get =
      '$baseUrl/admin-panel/all-doctors-list/';
  static final String doctor_filter_get = '$baseUrl/doctor/doctor-filter/';
  //MY DOCTOR
  static final String my_doctor = '$baseUrl/customer/my-doctor-profile/';
  //PAYMENTS
  static final String payments_get =
      '$baseUrl/appointments/clients-appointment-payments/';
  //UPCOMING SCAN DATES
  static final String upcomingScanDate_get = '$baseUrl/customer/scan-dates/';
  //MESSAGE
  static final String get_all_doctor = '$baseUrl/messages/get-clients-doctor/';
  static final String get_all_sales = '$baseUrl/messages/get-all-sales/';
  static final String get_all_consultant = '$baseUrl/admin-panel/all-consultants-list/';
  static final String doctor_messages = '$baseUrl/messages/get-clients-doctor/';
  static final String get_message = '$baseUrl/messages/get-all-messages';
  //CONSULTANT
  static final String all_consultant =
      '$baseUrl/admin-panel/all-consultants-list/';
  //SALES
  static final String all_sales = '$baseUrl/admin-panel/all-salesTeam-list/';
  //MESSAGE
  static final String client_send_message = '$baseUrl/messages/send-message/';
}

//************************************************************************************//
class dadApi{
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";
  //REGISTER
static final String register = '$baseUrl/dad-registration/';
//DISPLAY
static final String display = '$baseUrl/dad-dashboard/';
//REMEDY
static final String remedy = '$baseUrl/symptom-remedy/';
}
class consultantAPi {
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";
  //CONSULTATION
  static final String display =
      '$baseUrl/consultant/consultant-dashboard-details/';
  //CLINT THIS MONTH
  static final String consultant_thisMonth =
      '$baseUrl/sales/client-this-month/';
  //CLIENT PROFILE
  static final String clients_profile = '$baseUrl/doctor/patient-details/';
  //TRACKERS
  static final String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static final String medicine_get = '$baseUrl/customer/medicine-GET/';
  static final String customized_diet =
      '$baseUrl/consultant/add-customized-plan/';
  static final String exercise_get = '$baseUrl/customer/exercise-get/';
  static final String medical_get = '$baseUrl/customer/get-medical/';
  static final String contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static final String symptom_get = '$baseUrl/customer/Symptoms-GET/';
  static final String activity_get = '$baseUrl/customer/get-activity-tasks/';
  //MASSAGE
  static final String get_all_clients = '$baseUrl/messages/get-all-clients/';
  static final String consultant_massage =
      '$baseUrl/messages/get-all-messages/';
  static final String send_message = '$baseUrl/messages/send-message/';
  //ANALYSIS
  static final String symptoms_analysis = '$baseUrl/analytics/get-symptom-analysis/';
  static final String medical_analysis = '$baseUrl/analytics/get-medical-analysis/';
}

//*******************************************************************************************//

class doctorApi {
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";
  //DASHBOARD
  static final String display = '$baseUrl/doctor/doctor-dashboard-details/';
  //ALL CLIENT LIST
  static final String all_client_list = '$baseUrl/doctor/view-my-patients/';
  //CLIENT THIS MONTH
  static final String client_this_month = '$baseUrl/doctor/clients-this-month/';
  //APPOINTMENTS
  static final String today_appointment_get =
      '$baseUrl/doctor/todays-appointments/';
  static final String full_appointment_get =
      '$baseUrl/appointments/full-appointment/';
  static final String approval_request_get =
      '$baseUrl/doctor/approval-pending-appointments/';
  static final String reject_approval =
  '$baseUrl/appointments/reject-appointment/';
  static final String approve_approval =
  '$baseUrl/appointments/approve-appointment/';
  static final String bookAppointment_patch =
      '$baseUrl/appointments/reschedule-appointment/';
  static final String reschedule_patch =
      '$baseUrl/appointments/reschedule-appointment/';
  //TRACKERS
  static final String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static final String medicine_get = '$baseUrl/customer/medicine-GET/';
  static final String customized_diet =
      '$baseUrl/consultant/add-customized-plan/';
  static final String exercise_get = '$baseUrl/customer/exercise-get/';
  static final String medical_get = '$baseUrl/customer/get-medical/';
  static final String contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static final String symptom_get = '$baseUrl/customer/Symptoms-GET/';
  static final String activity_get_data =
      '$baseUrl/customer/get-activity-tasks/';
  // DOCTOR PROFILE
  static final String doctor_profile = '$baseUrl/doctor/doctor-profile/';
  static final String update_profile = '$baseUrl/profile-update/';
  //CLIENT PROFILE
  static final String clients_profile = '$baseUrl/doctor/patient-details/';
  //MESSAGE
  static final String send_message = '$baseUrl/messages/send-message/';
  static final String get_message = '$baseUrl/messages/get-all-messages/';
  static final String get_all_clients = '$baseUrl/get-all-clients-of-doctor/';
  //SUMMARY
  static final String summary_post = '$baseUrl/appointments/add-summary/';
  static final String summary_get = '$baseUrl/appointments/get-summary-doctor/';
  //CALL RECORDS
  static final String call_records = '$baseUrl/sales/get-all-call-responses/';
  // ANALYSIS
static final String symptoms_analysis = '$baseUrl/analytics/get-symptom-analysis/';
static final String medical_analysis = '$baseUrl/analytics/get-medical-analysis/';
  static final String analysis = '$baseUrl/analytics/client-criticalities/';
}

//********************************************************************************//
class ApiEndPoint {
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";
  // LOGIN
  static final String login = "$baseUrl/login/";
  static final String login_data = '$baseUrl/login-user-data/';
  // FORGOT PASSWORD
  static final String forgot_password = '$baseUrl/api/password_reset/';
  //PACKAGE
  static final String all_plan = '$baseUrl/payments/all-plans/';
  static final String free_package = '$baseUrl/payments/free-subscription/';
  //REGISTRATION
  static final String client_registration= '$baseUrl/client-registration/';
  static final String doctor_registation = '$baseUrl/doctor-registration/';
}

//********************************************************************************//

class salesApi {
  //BASEURL
  static final String baseUrl = "https://sukhprasavam.shebirth.com";

  //DISPLAY
  static final String sales_display = '$baseUrl/sales/sales-dashboard-details/';

  //MESSAGE
  static final String chat = '$baseUrl/messages/get-all-clients/';

  //NO UPDATE FROM CLIENT
  static final String no_update = '$baseUrl/sales/no-update-clients/';

//CLIENT THIS MONTH
  static final String client_this_month = '$baseUrl/sales/client-this-month/';

  // ANALYSIS
  static final String symptoms_analysis = '$baseUrl/analytics/get-symptom-analysis/';
  static final String medical_analysis = '$baseUrl/analytics/get-medical-analysis/';
  static final String analysis = '$baseUrl/analytics/client-criticalities/';

  //MESSAGE
  static final String all_clients = '$baseUrl	/messages/get-all-clients/';
  static final String all_message = '$baseUrl/messages/get-all-messages/';
  static final String send_message = '$baseUrl/messages/send-message/';

  //TRACKERS
  static final String tracker_diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static final String tracker_medicine_get = '$baseUrl/customer/medicine-GET/';
  static final String tracker_customized_diet =
      '$baseUrl/consultant/add-customized-plan/';
  static final String tracker_exercise_get = '$baseUrl/customer/exercise-get/';
  static final String tracker_medical_get = '$baseUrl/customer/get-medical/';
  static final String tracker_contraction_get =
      '$baseUrl/customer/all-dates-contractions/';
  static final String tracker_symptom_get = '$baseUrl/customer/Symptoms-GET/';
  static final String tracker_activity_get_data =
      '$baseUrl/customer/get-activity-tasks/';
  //UPDATE TRACKER
  static final String diet_get = '$baseUrl/customer/diet-tracker-GET/';
  static final String diet_post = '$baseUrl/customer/diet-tracker-add-POST/';
  static final String medicine_get = '$baseUrl/customer/medicine-GET/';
  static final String medicine_post = "$baseUrl/customer/medicine-update/";
  static final String exercise_get = '$baseUrl/customer/exercise-get/';
  static final String exercise_post = '$baseUrl/customer/exercise-submit/';
  static final String custom_exercise_post =
      '$baseUrl/customer/custom-exercise-submit/';
  static final String calories_post = '$baseUrl/customer/calories-burnt-add/';
  static final String activity_get = '$baseUrl/customer/get-activity-tasks/';
  static final String activity_predefined_post =
      '$baseUrl/customer/submit-activity/';
  static final String activity_custom_post =
      '$baseUrl/customer/submit-custom-activity/';
  static final String symptoms_get = "$baseUrl/customer/Symptoms-GET/";
  static final String symptoms_predefined_post =
      '$baseUrl/customer/symptoms-submit/';
  static final String symptoms_custom_post =
      "$baseUrl/customer/submit-custom-symptom/";
  static final String medical_get = '$baseUrl/customer/get-medical-form-data/';
  static final String medical_post = '$baseUrl/customer/medical-ADD/';
}
