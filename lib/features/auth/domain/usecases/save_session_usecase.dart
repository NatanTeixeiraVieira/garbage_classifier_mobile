import '../repositories/session_repository.dart';

class SaveSessionUseCase {
  final ISessionRepository _repository;

  SaveSessionUseCase(this._repository);

  Future<void> call(int userId) async {
    return _repository.saveCurrentUserId(userId);
  }
}
