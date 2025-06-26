import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/features/auth/data/data_source/data_source.dart';
import 'package:book_and_play/features/auth/data/repo/auth_repo_impl.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:book_and_play/features/auth/domain/usecase/signin_usecase.dart';
import 'package:book_and_play/features/owner/add_field/data/data_source/add_field_remote_data_source.dart';
import 'package:book_and_play/features/owner/add_field/data/repo/add_field_repo_impl.dart';
import 'package:book_and_play/features/owner/add_field/domain/repo/add_field_repo.dart';
import 'package:book_and_play/features/owner/owner_fields/data/data_sources/owner_fields_remote_data_source.dart';
import 'package:book_and_play/features/owner/owner_fields/data/repo/owner_fields_repo_impl.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/repo/owner_field_repo.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/usecase/owner_field_usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/data_source/tournaments_data_source.dart';
import 'package:book_and_play/features/owner/tournament/data/repo/add_tournament_repo.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/add_tournament_usecase.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/fetch_tournaments.dart';
import 'package:book_and_play/features/user/booking/data/data_source/booking_remote_data_source.dart';
import 'package:book_and_play/features/user/booking/data/repos/booking_repo_impl.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/fetch_fields_usecase.dart';
import 'package:book_and_play/features/user/tournaments/data/data_source/user_tournaments_remote_data_source.dart';
import 'package:book_and_play/features/user/tournaments/data/repo/user_tournament_repo_impl.dart';
import 'package:book_and_play/features/user/tournaments/domain/repo/user_tournament_repo.dart';
import 'package:book_and_play/features/user/tournaments/domain/usecase/fetch_tournaments_usecase.dart';
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

  getIt.registerSingleton<OwnerFieldsRemoteDataSource>(
    OwnerFieldsRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<OwnerFieldRepo>(OwnerFieldsRepoImpl());

  getIt.registerSingleton<OwnerFieldUsecase>(OwnerFieldUsecase());

  getIt.registerSingleton<TournamentsDataSource>(TournamentsDataSourceImpl());

  getIt.registerSingleton<TournamentRepo>(TournamentRepoImpl());

  getIt.registerSingleton<AddTournamentUsecase>(AddTournamentUsecase());

  getIt.registerSingleton<FetchTournamentsUsecase>(FetchTournamentsUsecase());

  getIt.registerSingleton<AddFieldRemoteDataSource>(
    AddFieldRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<AddFieldRepo>(AddFieldRepoImpl());

  getIt.registerSingleton<UserTournamentsRemoteDataSource>(
    UserTournamentsRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<UserTournamentRepo>(UserTournamentRepoImpl());

  getIt.registerSingleton<UserFetchTournamentsUsecase>(
    UserFetchTournamentsUsecase(),
  );
}
