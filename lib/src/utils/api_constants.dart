const String VERSION = "/v1.0/";
const String BASE_URL =
    "https://beauty-at-home.azurewebsites.net/api" + VERSION;

class ProviderAPIConstant {
  static const String END_POINT = BASE_URL + "/bookings";
  static const String GET_ALL = END_POINT;
}

class BookingAPIConstant {}

class EntityEndpoint {
  static const String AUTH_LOGIN = "auth/login";
  static const String BOOKING = "bookings";
  static const String SERVICE = "services";
}
