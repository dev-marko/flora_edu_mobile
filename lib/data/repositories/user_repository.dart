import 'package:uuid/uuid.dart';

import '../models/auth/flora_edu_user.dart';

class UserRepository {
  FloraEduUser? _user;

  Future<FloraEduUser?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(const Duration(milliseconds: 300),
        () => _user = FloraEduUser(id: const Uuid().v4()));
  }
}
