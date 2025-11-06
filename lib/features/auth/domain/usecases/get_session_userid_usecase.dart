import '../repositories/session_repository.dart';

class GetSessionUserIdUseCase {
  final ISessionRepository _repository;

  GetSessionUserIdUseCase(this._repository);

  Future<int?> call() async {
    return _repository.getCurrentUserId();
  }
}
