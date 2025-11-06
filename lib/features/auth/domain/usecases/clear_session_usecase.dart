import '../repositories/session_repository.dart';

class ClearSessionUseCase {
  final ISessionRepository _repository;

  ClearSessionUseCase(this._repository);

  Future<void> call() async {
    return _repository.clearCurrentUserId();
  }
}
