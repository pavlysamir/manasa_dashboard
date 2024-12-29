class EndPoint {
  static String baseUrl = "https://kerolos02-001-site1.ctempurl.com/";

  static String getAllUsers = "Home/GetAllUsers";

  static String login = "Account/Login";

  static String deleteAccount = "ProfileSetting/DeleteUserById";

  static String getUserByIdDashBoard = "DashBoard/GetUserById";

  static String updateProfileSettings = "DashBoard/UpdateProfileSetting";

  static String getUserDataEndPoint(id) {
    return "/User/$id";
  }
}

class ApiKey {
  static String status = "statusCode";
  static String errorMessage = "message";
  static String errors = "errors";

  static String token = "token";

  static String authorizationHeader = "Authorization";

  static String pageNum = "PageNumber";
  static String pageSize = "PageSize";

  static String userId = "userId";

  static bool authenticated = false;
}
