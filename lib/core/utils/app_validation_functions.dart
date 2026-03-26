import 'package:flutter/material.dart';


class AppValidationFunctions {
  //Validation Functions for validating user input
  static String? emailValidationFunction(String? email) {
    if (email == '') {
      return "Email can't be empty!";
    } else if (!email!.contains('@') && !email.contains('.')) {
      return 'Invalid email format!';
    } else {
      return null;
    }
  }

  static String? passwordValidationFunction(String? password) {
    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (password == '') {
      return "Password can't be empty";
    } else if (password!.length < 8) {
      return "Password must be more than 8 characters";
    }   else if(!regex.hasMatch(password)){
      return ("Password should contain upper,lower,digit \nand Special character ");
    } else {
      return null;
    }
  }

  static String? passwordOldValidationFunction(String? password) {

    if (password == '') {
      return "Password can't be empty";
    } else {
      return null;
    }
  }
  static String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }

    // Use a regex pattern for basic USA phone number validation
    // String pattern = r'^\+?[0-9]{10}$';
    // RegExp regExp = RegExp(pattern);
    //
    // if (!regExp.hasMatch(value)) {
    //   return 'Invalid phone number';
    // }
    if (value.replaceAll('-', '').length < 10) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? defaultValidationFunction(String? tval) {
    if (tval == "") {
      return "$tval required";
      // return "please fill the form completely";
    }
    return null;
  }

  static String? defaultFormValidationFunction(String? tval, String header,
      {bool checkIfEmpty = true}) {
    if (checkIfEmpty) {
      if (tval == "") {
        return "$header required";
        // return "please fill the $header";
      }
    }
    if (tval != "") {
      // if (tval!.length < 4) {
      //   return "the $header is too short";
      // }
    }
    return null;
  }

  static String? fieldConfirmationFunction(
      String? val, TextEditingController txt) {
    if (val != txt.text) {
      return "fields are not matched";
    }
    return null;
  }


}
