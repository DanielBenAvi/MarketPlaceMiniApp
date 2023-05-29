class Validator {
  bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    // validate the email with a regex
    if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(email) ==
        false) {
      return false;
    }

    return true;
  }

  bool isNotEmpty(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}
