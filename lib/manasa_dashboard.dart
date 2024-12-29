import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/core/api/dio_consumer.dart';
import 'package:manasa_dashboard/core/utils/app_router.dart';
import 'package:manasa_dashboard/core/utils/service_locator.dart';
import 'package:manasa_dashboard/features/home/data/home_repo/home_repo.dart';
import 'package:manasa_dashboard/features/home/managers/cubit/home_cubit.dart';

class ManasaDashboard extends StatelessWidget {
  const ManasaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepo(getIt.get<DioConsumer>())),
      child: MaterialApp.router(
        locale: const Locale('ar'),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
