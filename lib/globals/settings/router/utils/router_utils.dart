// Create enum to represent different routes
enum APP_PAGE { onBoard, auth, home }

extension AppPageExtension on APP_PAGE {
  // create path for routes
  String get routePath {
    switch (this) {
      case APP_PAGE.home:
        return "/";

      case APP_PAGE.onBoard:
        return "/onboard";

      case APP_PAGE.auth:
        return "/auth";

      default:
        return "/";
    }
  }

  // for named routes
  String get routeName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";

      case APP_PAGE.onBoard:
        return "ONBOARD";

      case APP_PAGE.auth:
        return "AUTH";

      default:
        return "HOME";
    }
  }

  // for page titles to use on appbar
  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Demo";

      default:
        return "Demo";
    }
  }
}
