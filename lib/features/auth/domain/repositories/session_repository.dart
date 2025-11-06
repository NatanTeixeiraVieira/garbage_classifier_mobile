abstract interface class ISessionRepository {
  Future<void> saveCurrentUserId(int id);
  Future<int?> getCurrentUserId();
  Future<void> clearCurrentUserId();
}
