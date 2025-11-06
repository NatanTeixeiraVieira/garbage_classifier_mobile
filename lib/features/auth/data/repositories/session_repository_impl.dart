import '../../domain/repositories/session_repository.dart';
import '../datasources/local_database_datasource.dart';

class SessionRepositoryImpl implements ISessionRepository {
  final ILocalDatabaseDataSource _localDataSource;

  SessionRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveCurrentUserId(int id) async {
    await _localDataSource.setCurrentUserId(id);
  }

  @override
  Future<int?> getCurrentUserId() async {
    return _localDataSource.getCurrentUserId();
  }

  @override
  Future<void> clearCurrentUserId() async {
    await _localDataSource.clearCurrentUserId();
  }
}
