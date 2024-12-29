import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/core/utils/service_locator.dart';
import 'package:manasa_dashboard/core/utils/shared_preferences_cash_helper.dart';
import 'package:manasa_dashboard/core/utils/simple_bloc_observer.dart';
import 'package:manasa_dashboard/manasa_dashboard.dart';

void main() async {
  setUpServiceLocator();

  await getIt.get<CashHelperSharedPreferences>().init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const ManasaDashboard());
}
