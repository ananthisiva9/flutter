class ApiEndPoint {
  //BASEURL
  static const String baseUrl = "https://www.railmitraa.app:8088";

  //static const String baseUrl = "http://192.168.0.129:8000";
  //LOGIN
  static const String login = '$baseUrl/usrserv/auth_token';
  //SIGNUP
  static const String signUp = '$baseUrl/usrserv/signup';

  //NAME THE APP
  // ignore: constant_identifier_names
  static const String name_the_app =
      '$baseUrl/contestserv/contest_appname_create';

  // ignore: constant_identifier_names
  static const String name_the_app_history =
      '$baseUrl/contestserv/user_appname_history';

  //POTTERY CONTEST
  // ignore: constant_identifier_names
  static const String potery_contest =
      '$baseUrl/contestserv/contest_poem_create';

  // ignore: constant_identifier_names
  static const String poetry_contest_history =
      '$baseUrl/contestserv/user_poem_history';

  //IMAGE UPLOAD CONTEST
  // ignore: constant_identifier_names
  static const String image_upload =
      '$baseUrl/contestserv/contest_image_create';

  // ignore: constant_identifier_names
  static const String image_upload_history =
      '$baseUrl/contestserv/user_image_history';

  //OTP VERIFICATION
  // ignore: constant_identifier_names
  static const String email_verification = '$baseUrl/usrserv/send_otp';
  static const String otp = '$baseUrl/usrserv/validate_otp';

  // static const String quiz =
  //     '$baseUrl/contestserv/fetch_quiz_app_questions_android';
  //QUIZ
  static const String quiz =
      '$baseUrl/contestserv/fetch_quiz_app_questions_android';

  // ignore: constant_identifier_names
  static const String submit_contest = '$baseUrl/contestserv/score_quiz';

  //TRIVIA CONTEST
  static const String triva =
      '$baseUrl/contestserv/fetch_trivia_app_questions_android';

  // ignore: constant_identifier_names
  static const String submit_triva = '$baseUrl/contestserv/score_trivia';

  //PROFILE
  static const String profile = '$baseUrl/usrserv/employee_by_id/';

  //EDIT PROFILE
  // ignore: constant_identifier_names
  static const String edit_profile = '$baseUrl/usrserv/employee_by_id/';

  //FEEDBACK
  static const String feedback = '$baseUrl/usrserv/feedback';

  //FORGOT PASSWORD
  // ignore: constant_identifier_names
  static const String forgot_password = '$baseUrl/usrserv/forgotPassword';

  //LOGOUT
  static const String logout = '$baseUrl/usrserv/logout';

  //DEVICE LOG
  // ignore: constant_identifier_names
  static const String log_start = '$baseUrl/usrserv/moduleChangesLogAndroid';

  // ignore: constant_identifier_names
  static const String log_end = '$baseUrl/usrserv/moduleChangesLogAndroid';

  //CONTEST MASTER
  static const String contest = '$baseUrl/usrserv/contestModuleHistoryAdmin';

//CATEGORY
  static const String category =
      '$baseUrl/usrserv/contestquestioncategorycreate';

//STATE
  static const String state = '$baseUrl/usrserv/fetch_state_scroll';

//CITY
  static const String city = '$baseUrl/usrserv/fetch_city_scroll';

  //UPDATE
  static const String update_email = '$baseUrl/usrserv/email_update';

  //TRIVIA
  static const String trivia_score = '$baseUrl/contestserv/score_trivia';

//QUIZ
  static const String quiz_score = '$baseUrl/contestserv/score_quiz';

  //CONTEST TYPE
  static const String contestType = '$baseUrl/usrserv/contesttype';

  static const String securitycode = '$baseUrl/usrserv/pin_auth_validate';

  //HISTORY
  static const String app_history = '$baseUrl/contestserv/user_appname_history';
  static const String poem_history = '$baseUrl/contestserv/user_poem_history';
  static const String image_history = '$baseUrl/contestserv/user_image_history';
  static const String quiz_history = '$baseUrl/contestserv/score_quiz';
  static const String trivia_history = '$baseUrl/contestserv/score_trivia';
  //TOKEN
static const String token = '$baseUrl/usrserv/auth_token_check';
}

//*****************************************************************************************//
class JudgeApi {
  //BASEURL
  static const String baseUrl = "https://www.railmitraa.app:8088";
  // static const String baseUrl = "http://192.168.0.129:8000";
  //LOGIN
  static const String login = '$baseUrl/usrserv/auth_token';

  //LOGOUT
  static const String logout = '$baseUrl/usrserv/logout';

  //DASHBOARD
  static const String dashboard = '$baseUrl/judgeserv/contest_judge_view';
  //COMPLETED
  static const String completed =
      '$baseUrl/judgeserv/contest_judge_complete_status';
  //MISSED
  static const String missed = '$baseUrl/judgeserv/contest_judge_missed_status';

  //PROFILE
  static const String profile = '$baseUrl/usrserv/employee_by_id/';

  //CONTEST DETAILS
  static const String contest_list =
      '$baseUrl/judgeserv/contest_judge_mapping_view';

  //TABLE DATA
  static const String table_data =
      '$baseUrl/judgeserv/contest_judge_view_by_id';

//SUBMIT USER DATA
  static const String user_data =
      '$baseUrl/judgeserv/contest_judge_preview_temp';
  //SUBMIT_POSITION
  static const String submit_position =
      '$baseUrl/judgeserv/contest_judge_price_create';
}