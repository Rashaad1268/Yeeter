final emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

String? validateUsername(String? username) {
  if (username == null) {
    return "Username can't be empty";
  } else if (username.length <= 1) {
    return 'Username should be atleast 2 characters';
  } else if (username.length > 30) {
    return "Username can't be longer than 30 characters";
  }
  return null;
}

String? validateEmail(String? email) {
  if (email == null || emailRegex.hasMatch(email) == false) {
    return 'Enter a valid email';
  }
  return null;
}

String? validateHandle(String? email) {
  // TODO: Implement this
  return null;
}

String? validatePassword(String? email) {
  // TODO: Implement this
  return null;
}
