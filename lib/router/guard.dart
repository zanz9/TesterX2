import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerx2/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        resolver.redirect(const LoginRoute());
      } else {
        resolver.next(true);
      }
    });
  }
}
