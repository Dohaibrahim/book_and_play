import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/features/auth/data/data_source/data_source.dart';
import 'package:book_and_play/features/auth/data/repo/auth_repo_impl.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:book_and_play/features/auth/domain/usecase/signin_usecase.dart';
import 'package:book_and_play/features/auth/domain/usecase/signup_usecase.dart';
import 'package:book_and_play/features/user/booking/data/data_source/booking_remote_data_source.dart';
import 'package:book_and_play/features/user/booking/data/repos/booking_repo_impl.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/fetch_fields_usecase.dart';
import 'package:book_and_play/features/user/user_booking/data/data_source/user_booking_remote_data_source.dart';
import 'package:book_and_play/features/user/user_booking/data/repo/user_booking_repo_impl.dart';
import 'package:book_and_play/features/user/user_booking/domain/repo/user_booking_repo.dart';
import 'package:book_and_play/features/user/user_booking/domain/usecases/user_bookings_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());

  //getIt.registerSingleton<SignupUsecase>(SignupUsecase());

  getIt.registerSingleton<SigninUsecase>(SigninUsecase());

  getIt.registerSingleton<BookingRemoteDataSource>(
    BookingRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<BookingRepo>(BookingRepoImpl());

  getIt.registerSingleton<FetchFieldsUsecase>(
    FetchFieldsUsecase(allFieldsRepo: getIt.get<BookingRepo>()),
  );

  getIt.registerSingleton<UserBookingRemoteDataSource>(
    UserBookingRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<UserBookingRepo>(UserBookingRepoImpl());

  getIt.registerSingleton<UserBookingsUsecase>(
    UserBookingsUsecase(userBookingRepo: getIt<UserBookingRepo>()),
  );
}
