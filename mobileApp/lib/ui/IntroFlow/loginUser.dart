class LoginUser {
  String userName;

  String verificationCode;

  void addName(String name) {
    this.userName = name;
  }

  void addVerificationCode(String verificationCode) {
    this.verificationCode = verificationCode;
  }
}
