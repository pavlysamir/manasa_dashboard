import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manasa_dashboard/core/api/end_ponits.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/utils/service_locator.dart';
import 'package:manasa_dashboard/core/utils/shared_preferences_cash_helper.dart';
import 'package:manasa_dashboard/features/home/managers/cubit/home_cubit.dart';
import 'package:manasa_dashboard/features/home/presentation/screens/home_screen.dart';
import 'package:manasa_dashboard/features/home/presentation/screens/profile_screen.dart';
import 'package:manasa_dashboard/features/login/presentation/screens/login_screen.dart';

abstract class AppRouter {
  static const kHomeLayout = '/HomeLayout';
  static const kLoginScreen = '/LoginScreen';
  static const kProfileScreen = '/kProfileScreen';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation:
        getIt.get<CashHelperSharedPreferences>().getData(key: ApiKey.token) !=
                null
            ? kHomeLayout
            : kLoginScreen,
    routes: [
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
        redirect: (context, state) {
          if (getIt
                  .get<CashHelperSharedPreferences>()
                  .getData(key: ApiKey.token) !=
              null) {
            return kHomeLayout;
          }
          return kLoginScreen;
        },
        //redirect: (context, state) => _redirect(context),
      ),
      GoRoute(
        path: kHomeLayout,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: kProfileScreen,
          builder: (context, state) => ProfileScreen(),
          onExit: (context, state) async {
            // Call the async function
            await HomeCubit.get(context)!.getSearchedUsers(1).then((value) {
              pageNum = 1;
            });

            // Always allow navigation
            return true;
          }),
    ],
  );
}
