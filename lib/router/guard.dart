import 'package:auto_route/auto_route.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/utils/firestore/auth.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (AuthService().isAuth()) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
