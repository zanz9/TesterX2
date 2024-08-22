import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I<AuthRepository>().isAuth()) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
