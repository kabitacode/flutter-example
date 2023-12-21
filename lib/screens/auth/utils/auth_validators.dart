class AuthValidators {
  // Create error messages to send.

  static const String emailErrMsg =
      "Invalid Email Address, Please provide a valid email.";
  static const String passwordErrMsg =
      "Password must have at least 6 characters.";
  static const String confirmPasswordErrMsg = "Two passwords don't match.";

  // A simple email validator that  checks presence and position of @

  String? emailVaildator(String? val) {
    final String email = val as String;
    // If length of email is <=3 then its invlaid
    if (email.length <= 3) return emailErrMsg;
    // Check if it has @
    final hasAtSymbol = email.contains('@');
    // find position of @
    final indexOfAt = email.indexOf('@');
    // Check numbers of @
    final numbersOfAt = "@".allMatches(email).length;
    // Valid if has @
    if (!hasAtSymbol) return emailErrMsg;
    // and  if number of @ is only 1
    if (numbersOfAt != 1) return emailErrMsg;
    //and if  '@' is not the first or last character
    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    // Else its valid
    return null;
  }
}
