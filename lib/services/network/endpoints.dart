class EndPoints {
  static const String baseEndPoint = "https://one-pice1.com/api/";

  //Auth and User Actions
  static const String registerEndPoint = "delivery_insert.php";
  static const String signInEndPoint = "delivery_login.php";
  static const String sendOtpMail = "send_otp_mail.php";
  // static const String deliveryData = "delivery_search.php";
  static const String getProfile = 'delivery_search.php';
  static const String updateProfile = 'delivery_update.php';
  static const String deliveryRequests = "orders_search.php";
  static const String verifyOtpMail = "delivery_email_verification_state_update.php";
  static const String verifyOtpPhone = "delivery_phone_verification_state_update.php";
  static const String AuthuID = "delivery_auth.php";
  static const String acceptReject = "order_accept_state_update.php";
  static const orderStateUpdate = 'order_state_update_by_delivery.php';
  static const String deliveryStateUpdate = "delivery_state_update.php";
  static const String uploadImg = "order_delivered_state_update.php";
  static const String contracts = 'contract_search.php';

  static const String orderProblemInsert = 'order_problem_insert.php';
  static const orderDetails = 'get_order_info.php?order_id=';
  static const createNewPassword = 'delivery_update_password.php';
  static const forgetPassword = 'delivery_generate_default_password.php';
  static const String delivery_photo_update = '/delivery_photo_update.php';

}
