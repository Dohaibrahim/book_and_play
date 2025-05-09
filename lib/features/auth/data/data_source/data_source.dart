import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signup_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, SignupResponse>> signUp(SignupReqParams signupReq);

  /*Future<Either<Failure, LoginResponse>> signIn(SigninReqParams signInReq);

  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordReq forgetPasswordReq);
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      ResetPasswordReq resetPasswordReq, String token);*/
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<Either<Failure, SignupResponse>> signUp(
    SignupReqParams signupReq,
  ) async {
    try {
      var response = await getIt<DioClient>().post(
        ApiUrls.signup,
        data: signupReq.toJson(),
      );

      final signupResponse = SignupResponse.fromJson(response.data);

      if (signupResponse.user == null) {
        return Left(Failure(signupResponse.message));
      }

      return Right(signupResponse);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response!.data}');

        final Map<String, dynamic> responseData =
            e.response!.data is Map<String, dynamic> ? e.response!.data : {};

        final errorResponse = SignupResponse.fromJson(responseData);
        return Left(Failure(errorResponse.message));
      }
      return Left(Failure('Dio error: ${e.message}'));
    } catch (e) {
      print('Unexpected error: $e');
      return Left(Failure(e.toString()));
    }
  }

  /*@override
  Future<Either<Failure, LoginResponse>> signIn(
      SigninReqParams signInReq) async {
    try {
      var response = await getIt<DioClient>().post(
        ApiUrls.login,
        data: signInReq.toMap(),
      );

      // Parse the response using SignupResponse.fromJson
      final loginResponse = LoginResponse.fromJson(response.data);

      // Check if the user is null, indicating failure
      if (loginResponse.user == null) {
        return Left(Failure(loginResponse.message)); // Return error message
      }

      return Right(loginResponse); // Return success
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response!.data}');

        final Map<String, dynamic> responseData =
            e.response!.data is Map<String, dynamic> ? e.response!.data : {};

        // Use fromJson to extract the error message
        final errorResponse = LoginResponse.fromJson(responseData);
        return Left(Failure(errorResponse.message));
      }
      // Handle Dio error without a response
      return Left(Failure('Dio error: ${e.message}'));
    } catch (e) {
      print('Unexpected error: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordReq forgetPasswordReq) async {
    try {
      var request = await getIt<DioClient>().post(
        ApiUrls.forgetPassword,
        data: forgetPasswordReq.toMap(),
      );
      var response = ForgetPasswordResponse.fromMap(request.data);

      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure('error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      ResetPasswordReq resetPasswordReq, String token) async {
    try {
      var request = await getIt<DioClient>().post(
        '${ApiUrls.resetPassword}/$token',
        data: resetPasswordReq.toMap(),
      );

      var response = ResetPasswordResponse.fromMap(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure('error : ${e.toString()}'));
    }
  }*/
}
