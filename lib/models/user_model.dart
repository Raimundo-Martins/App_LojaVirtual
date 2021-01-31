import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  void signUp() {}

  void signIn() {
    isLoading = true;
    notifyListeners();
  }

  void recoverPass() {}

  //bool isLoggedIn() {}
}
