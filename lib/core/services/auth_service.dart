import 'package:flutter/material.dart';

enum UserRole { admin, staff }

class UserSession {
  final String username;
  final UserRole role;
  final String tenantId;

  UserSession({
    required this.username,
    required this.role,
    required this.tenantId,
  });
}

class AuthService with ChangeNotifier {
  UserSession? _currentUser;
  UserSession? get currentUser => _currentUser;

  bool login(String username, String password) {
    // Mocking the requested users
    if (username == 'tutty' && password == '100889') {
      _currentUser = UserSession(
        username: 'tutty',
        role: UserRole.admin,
        tenantId: 'pitbull_central',
      );
      notifyListeners();
      return true;
    } else if (username == 'tutty2' && password == '100889') {
      _currentUser = UserSession(
        username: 'tutty2',
        role: UserRole.staff,
        tenantId: 'pitbull_central',
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
