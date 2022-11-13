class ValidatorEmail {
  static String? validateEmail(String email) {
    if(email.isEmpty) {
      return "Required Filed";
    }

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if(!regExp.hasMatch(email)) {
      return "Please Enter a valid email id";
    }
  }
}