import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manasa_dashboard/core/api/api_consumer.dart';
import 'package:manasa_dashboard/core/api/end_ponits.dart';
import 'package:manasa_dashboard/core/errors/exceptions.dart';
import 'package:manasa_dashboard/core/utils/service_locator.dart';
import 'package:manasa_dashboard/core/utils/shared_preferences_cash_helper.dart';
import 'package:manasa_dashboard/features/login/data/models/login_user_moodel.dart';

class LoginRepo {
  final ApiConsumer api;

  LoginRepo(this.api);

  Future<Either<String, LoginUserModel>> login(
      String phoneNum, String password) async {
    try {
      final response = await api.post(EndPoint.login, data: {
        'phoneNumber': '${'+2'}$phoneNum',
        'password': password,
      });

      var data = LoginUserModel.fromJson(response['data']);

      getIt
          .get<CashHelperSharedPreferences>()
          .saveData(key: ApiKey.token, value: data.token);

      getIt
          .get<CashHelperSharedPreferences>()
          .saveData(key: ApiKey.userId, value: data.id);

      return Right(data);
    } on DioException catch (e) {
      // Check if DioException contains additional information
      final errorMessage =
          e.response?.data['errorMessage'] ?? 'Unknown error occurred';
      return Left(errorMessage);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'Server error');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }
}
