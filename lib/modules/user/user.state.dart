import 'package:flutter_project/models/user.dart';

class UserState {
  late User user;
  UserState();
  UserState.fill(this.user);

  User get props => user;
}
