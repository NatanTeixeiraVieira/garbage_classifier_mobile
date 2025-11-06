import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';
export 'app_state.dart';
import '../../domain/usecases/clear_session_usecase.dart';

/// Global app cubit to hold basic session state (current user id) and handle logout.
class AppCubit extends Cubit<AppState> {
  final ClearSessionUseCase _clearSessionUseCase;

  AppCubit(this._clearSessionUseCase) : super(const AppState());

  void setCurrentUserId(int id) => emit(state.copyWith(currentUserId: id));

  void clearCurrentUser() async {
    await _clearSessionUseCase();
    emit(const AppState());
  }

  bool get isLogged => state.currentUserId != null;
}
