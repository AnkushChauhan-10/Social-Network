enum AppRoutes {
  splash._(_AppRoutes.splash),

  ///auth
  auth._(_AppRoutes.auth),
  signUp._(_AppRoutes.signUp),
  accountPicker._(_AppRoutes.accountPicker),
  logIn._(_AppRoutes.logIn),

  ///
  profileOnBoarding._(_AppRoutes.profileOnBoarding),

  ///
  home._(_AppRoutes.home),
  search._(_AppRoutes.search),
  createPost._(_AppRoutes.createPost),
  notification._(_AppRoutes.notification),
  profile._(_AppRoutes.profile)
  ///
  ;

  const AppRoutes._(this._route);

  final _Route _route;

  String get path => _route.path;

  String get fullPath => _route.fullPath;
}

class _AppRoutes {
  static const splash = _Route("splash");

  static const auth = _Route("auth");
  static const accountPicker = _Route("account_picker");
  static const signUp = _Route("signUp");
  static const logIn = _Route("logIn");

  static const profileOnBoarding = _Route("profileOnBoarding");

  static const home = _Route("home");

  static const search = _Route("search");

  static const notification = _Route("notification");

  static const profile = _Route("profile");

  static const createPost = _Route("createPost");
}

class _Route {
  const _Route(this._path, {this.parent});

  final String _path;
  final _Route? parent;

  String get fullPath {
    if (parent == null) return "/$_path";
    return "${parent!.fullPath}/$_path";
  }

  String get path {
    if (parent == null) return "/$_path";
    return _path;
  }
}
