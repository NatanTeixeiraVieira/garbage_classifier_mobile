abstract interface class IPasswordHashService {
  String hashPassword(String password);
  bool verifyPassword(String hashedPassword, String password);
}
