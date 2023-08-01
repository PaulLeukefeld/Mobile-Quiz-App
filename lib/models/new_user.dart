/// User Class that is used during the on boarding process to collect new user data
class NewUser {
  String _state;
  String _email;
  String _password;
  String _userName;
  int _profileImage;

  /// Method that sets the state
  void setUserState(String state) {
    this._state = state;
  }

  /// Method that sets the email
  void setUserEmail(String email) {
    this._email = email;
  }

  /// Method that sets the password
  void setUserPassword(String password) {
    this._password = password;
  }

  /// Method that sets the username
  void setUsername(String userName) {
    this._userName = userName;
  }

  /// Method that sets the profileImage
  void setUserProfileimage(int profileImage) {
    this._profileImage = profileImage;
  }

  /// Method that returns the current state of the user
  String getUserState() {
    return this._state;
  }

  /// Method that returns the current email address of the user
  String getUserEmail() {
    return this._email;
  }

  /// Method that returns the current password of the user
  String getUserPassword() {
    return this._password;
  }

  /// Method that returns the current username of the user
  String getUsername() {
    return this._userName;
  }

  /// Method that returns the number of the avatar of the user
  int getProfileImage() {
    return this._profileImage;
  }
}
