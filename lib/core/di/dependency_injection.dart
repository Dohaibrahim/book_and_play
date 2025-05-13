import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/features/auth/data/data_source/data_source.dart';
import 'package:book_and_play/features/auth/data/repo/auth_repo_impl.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:book_and_play/features/auth/domain/usecase/signin_usecase.dart';
import 'package:book_and_play/features/auth/domain/usecase/signup_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());

  getIt.registerSingleton<SignupUsecase>(SignupUsecase());

  getIt.registerSingleton<SigninUsecase>(SigninUsecase());
}
