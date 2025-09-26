import '../../../repositories/auth_repository.dart';

class LogoutUser{
  final AuthRepository _repo;
  LogoutUser(this._repo);

  Future<void> call() {
    return _repo.logout();
  }
}