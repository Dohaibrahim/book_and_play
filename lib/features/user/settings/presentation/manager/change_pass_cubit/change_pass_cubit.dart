import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/user/settings/domain/usecase/change_password_usecase.dart';
import 'package:book_and_play/features/user/settings/presentation/manager/change_pass_cubit/change_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit() : super(ChangePassInitialState());

  Future<void> changePass(ChangePassReq changePassReq) async {
    emit(ChangePassLoadingState());
    final result = await getIt<ChangePasswordUsecase>().call(changePassReq);
    result.fold(
      (failure) {
        emit(ChangePassFailureState(errorMessage: failure.message));
      },
      (data) async {
        await saveUserToken(data.token);
        emit(ChangePassSuccessState(message: data.message));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setData(SharedPrefKeys.userToken, token);
    getIt<DioClient>().setTokenIntoHeaderAfterLogin(token);
  }
}
