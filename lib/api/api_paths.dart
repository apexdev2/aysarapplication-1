class ApiEndPoints {
  static const String _baseUrl = productionUrl;
  static const String _apiBaseUrl = '${_baseUrl}api/client/';
  static const String _apiVersionBaseUrl = '${_apiBaseUrl}v1/';
  static const String apiFullUrl = _apiVersionBaseUrl;
  static const String productionUrl = "https://aysar.sa/";
  static String countries = '${apiFullUrl}shared/countries';
  static String identityType = '${apiFullUrl}shared/identity-type';
  static String registerClient = '${apiFullUrl}appointments/register-client';

  /// Auth
  static const String login = '${apiFullUrl}login';
  static const String register = '${apiFullUrl}register';
  static const String sliders = '${apiFullUrl}sliders';
  static const String properties = '${apiFullUrl}properties';
  static const String pages = '${apiFullUrl}shared/pages';
  static const String faqs = '${apiFullUrl}shared/faqs';
  static const String issues = '${apiFullUrl}shared/issues';
  static const String profile = '${apiFullUrl}profile';
  static const String maintenance = '${apiFullUrl}shared/maintenance-request';
  static const String forgotPassword = '${apiFullUrl}forgotPassword';
  static const String verifyOtp = '${apiFullUrl}verify-otp';
  static const String resetPassword = '${apiFullUrl}resetPassword';
  static const String logout = '${apiFullUrl}logout';
  static const String myProfile = '${apiFullUrl}profile/me';
  static const String deleteAccount = '${apiFullUrl}settings/delete-account';
  static const String changepassword = '${apiFullUrl}settings/change-password';
  static const String verifychangepassword =
      '${apiFullUrl}profile/verify-change-password-otp';
  static const String notifications = '${apiFullUrl}notifications';
  static const String changedefaultlanguage =
      '${apiFullUrl}settings/change-default-language';

// Reservations
  static const String reservations = '${apiFullUrl}reservations';

  static const String tickets = '${apiFullUrl}tickets';
  static const String companies = '${apiFullUrl}companies';

  static const String reservationStatus =
      '${apiFullUrl}shared/reservation-status';
// appointments
  static const String checkmobileclientnts =
      '${apiFullUrl}appointments/check-mobile-client';
  static const String services = '${apiFullUrl}shared/services';
  static const String storeAppointments = '${apiFullUrl}appointments';
  static const String confirmReservations =
      '${apiFullUrl}reservations/confirm-reservations';

  static const String activateNotification =
      '${apiFullUrl}settings/change-activate-notification';
}
