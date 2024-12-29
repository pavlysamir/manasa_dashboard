import 'package:dartz/dartz.dart';
import 'package:manasa_dashboard/core/api/api_consumer.dart';
import 'package:manasa_dashboard/core/api/end_ponits.dart';
import 'package:manasa_dashboard/core/errors/exceptions.dart';
import 'package:manasa_dashboard/features/home/data/models/user_data_model.dart';
import 'package:manasa_dashboard/features/home/data/models/user_specific_data_model.dart';

class HomeRepo {
  final ApiConsumer api;

  HomeRepo(this.api);

  Future<Either<String, ApiResponse>> getAllUsers({int pageNumber = 1}) async {
    try {
      final response = await api.post(EndPoint.getAllUsers, queryParameters: {
        ApiKey.pageNum: pageNumber,
        ApiKey.pageSize: 20,
      });

      return Right(ApiResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }

  Future<Either<String, ApiResponse>> getASearchedUsers(
      {String? lawyerName, int pageNumber = 1}) async {
    try {
      final response = await api.post(
        EndPoint.getAllUsers,
        queryParameters: {
          ApiKey.pageNum: pageNumber,
          ApiKey.pageSize: 20,
          'LawyerName': lawyerName
        },
      );

      return Right(ApiResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }

  Future<Either<String, UserData>> getUserData({required int userId}) async {
    try {
      final response = await api.get(
        EndPoint.getUserByIdDashBoard,
        queryParameters: {
          ApiKey.userId: userId,
        },
      );

      return Right(UserData.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }

  Future<Either<String, String>> deleteAccount({required int userID}) async {
    try {
      final response = await api
          .delete(EndPoint.deleteAccount, queryParameters: {'userId': userID});

      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }

  Future<Either<String, String>> updateProfileSetting(
      {required int userID, required int status}) async {
    try {
      final response = await api.put(EndPoint.updateProfileSettings,
          queryParameters: {'userId': userID, 'statusId': status});

      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }
}
