class Validator {
  bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    // validate the email with a regex
    if (RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
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
