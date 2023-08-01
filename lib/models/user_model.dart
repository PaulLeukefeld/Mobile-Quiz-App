///User model that holds all of the information associated with a user
class UserModel {
  final String uid;
  String userName;
  String state;
  String time;
  String email;
  String password;
  bool proUser;
  bool guestUser;
  int profileImage;
  String levelOneStatus;
  String levelTwoStatus;
  String levelThreeStatus;
  String levelOneTime;
  String levelTwoTime;
  String levelThreeTime;
  int alltimeAgainstTheTimeScore;
  int monthlyAgainstTheTimeScore;
  int dailyAgainstTheTimeScore;
  DateTime timeOfalltimeAgainstTheTimeHighscore;
  DateTime timeOfMonthlyAgainstTheTimeHighscore;
  DateTime timeOfDailyAgainstTheTimeHighscore;

  UserModel(
      {this.uid,
      this.userName,
      this.profileImage,
      this.state,
      this.time,
      this.email,
      this.password,
      this.proUser,
      this.guestUser,
      this.levelOneStatus,
      this.levelTwoStatus,
      this.levelThreeStatus,
      this.levelOneTime,
      this.levelTwoTime,
      this.levelThreeTime,
      this.alltimeAgainstTheTimeScore,
      this.monthlyAgainstTheTimeScore,
      this.dailyAgainstTheTimeScore,
      this.timeOfalltimeAgainstTheTimeHighscore,
      this.timeOfMonthlyAgainstTheTimeHighscore,
      this.timeOfDailyAgainstTheTimeHighscore});

  /// Method that sets the state
  void setUserState(String state) {
    this.state = state;
  }

  /// Method that sets the email
  void setUserEmail(String email) {
    this.email = email;
  }

  /// Method that sets the password
  void setUserPassword(String password) {
    this.password = password;
  }

  /// Method that sets the username
  void setUsername(String userName) {
    this.userName = userName;
  }

  /// Method that sets the profileImage
  void setUserProfileimage(int profileImage) {
    this.profileImage = profileImage;
  }

  /// Method that returns the current state of the user
  String getUserState() {
    return this.state;
  }

  /// Method that returns the current email address of the user
  String getUserEmail() {
    return this.email;
  }

  /// Method that returns the current password of the user
  String getUserPassword() {
    return this.password;
  }

  /// Method that returns the current username of the user
  String getUsername() {
    return this.userName;
  }

  /// Method that returns the number of the avatar of the user
  int getProfileImage() {
    return this.profileImage;
  }

  /// Method that returns the level one status
  String getLevelOneStatus() {
    return this.levelOneStatus;
  }

  /// Method that returns the level two status
  String getLevelTwoStatus() {
    return this.levelTwoStatus;
  }

  /// Method that returns the level three status
  String getLevelThreeStatus() {
    return this.levelThreeStatus;
  }

  /// Method that sets the level one status
  void setLevelOneStatus(String levelOneStatus) {
    this.levelOneStatus = levelOneStatus;
  }

  /// Method that sets the level two status
  void setLevelTwoStatus(String levelTwoStatus) {
    this.levelTwoStatus = levelTwoStatus;
  }

  /// Method that sets the level three status
  void setLevelThreeStatus(String levelThreeStatus) {
    this.levelThreeStatus = levelThreeStatus;
  }
}
