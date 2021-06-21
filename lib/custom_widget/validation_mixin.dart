import 'package:admin_app/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';

  String validateUserName(String userName) {
    Pattern pattern = r'^[0-9]';

    Pattern patternsample =
        r'^(?![_.])(?![0-9])(?!.*?[!@#\$&*~])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';

    RegExp regex = new RegExp(pattern);
    RegExp regexsample = new RegExp(patternsample);

    if (userName.trim().length == 0) {
      return AppLocalizations.of(context)
          .translate('user_name_validation_empty');
    } else {
      if (userName.startsWith(regex)) {
        return AppLocalizations.of(context).translate('user_name_validation');
      } else {
        if (!regexsample.hasMatch(userName)) {
          return AppLocalizations.of(context)
              .translate('user_name_validation_sample');
        } else {
          if (!isLength(userName, 8, 30)) {
            return AppLocalizations.of(context)
                .translate('user_name_valodation_length');
          }
        }
      }
    }
    return null;
  }

  String validateFirstName(String fisrtName) {
    if (fisrtName.trim().length == 0) {
      return AppLocalizations.of(context)
          .translate('first_name_validation_empty');
    } else {
      if (!isLength(fisrtName, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('first_name_validation_lenght');
      }
    }
    return null;
  }

  String validatelastName(String lastName) {
    if (lastName.trim().length == 0) {
      return AppLocalizations.of(context)
          .translate('last_name_validation_empty');
    } else {
      if (!isLength(lastName, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('last_name_validation_lenght');
      }
    }
    return null;
  }

  String validatelevel(String level) {
    if (level.trim().length == 0) {
      return AppLocalizations.of(context).translate('level_name_validation');
    } else {
      if (!isLength(level, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('level_name_validation_lenght');
      }
    }
    return null;
  }

  String validateSubjects(String subjects) {
    if (subjects.trim().length == 0) {
      return AppLocalizations.of(context).translate('subject_name_validation');
    } else {
      if (!isLength(subjects, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('subject_name_validation_lenght');
      }
    }
    return null;
  }
    String validateAbberviation(String abberviation) {
    if (abberviation.trim().length == 0) {
      return AppLocalizations.of(context).translate('abberviation_name_validation');
    } else {
      if (!isLength(abberviation, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('abberviation_name_validation_lenght');
      }
    }
    return null;
  }

  String validateMaterial(String material) {
    if (material.trim().length == 0) {
      return AppLocalizations.of(context).translate('material_name_validation');
    }
    return null;
  }

  String validateClass(String classe) {
    if (classe.trim().length == 0) {
      return AppLocalizations.of(context).translate('class_name_validation');
    } else {
      if (!isLength(classe, 2, 30)) {
        return AppLocalizations.of(context)
            .translate('class_name_validation_lenght');
      }
      return null;
    }
  }

  String validateUserEmail(String userEmail) {
    if (userEmail.trim().length == 0) {
      return AppLocalizations.of(context).translate('email_validation');
    } else {
      if ((!isEmail(userEmail))) {
        return AppLocalizations.of(context)
            .translate('email_validation_example');
      }
    }

    return null;
  }

  String validateActivationCode(String activationCode) {
    if (activationCode.trim().length == 0) {
      return AppLocalizations.of(context)
          .translate('activation_code_validation');
    }
    return null;
  }

  String validateOldPassword(String oldPassword) {
    if (oldPassword.trim().length == 0) {
      return AppLocalizations.of(context).translate('old_password_validation');
    }
    return null;
  }

  String validatePasswordsignup(String password) {
    _password = password;

    // Pattern pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    Pattern pattern = r'^(?![_.])[a-zA-Z0-9!@#\$&*~._]+(?<![_.]).{7,}$';

    RegExp regex = new RegExp(pattern);
    print(password);
    if (password.isEmpty) {
      return AppLocalizations.of(context).translate('password_validation');
    } else {
      if (password.length < 8)
        return AppLocalizations.of(context)
            .translate('password_validation_symbols');
      else
        return null;
    }
  }

  String validatePasswordsignin(String password) {
    print(password);
    if (password.isEmpty) {
      return AppLocalizations.of(context)
          .translate('password_validation_valid');
    }
    return null;
  }

  String validateemailsignin(String email) {
    print(email);
    if (email.isEmpty) {
      return AppLocalizations.of(context).translate('email_validation_valid');
    }
    return null;
  }

  String validateConfirmPassword(String confirmPassword) {
    if (confirmPassword.trim().length == 0) {
      return AppLocalizations.of(context)
          .translate('confirm_password_validation');
    } else if (_password != confirmPassword) {
      return AppLocalizations.of(context)
          .translate('confirm_password_validation_duplicat');
    }
    return null;
  }

  String validateUserPhone(String phone) {
    if (phone.trim().length == 0 || !isNumeric(phone)) {
      return AppLocalizations.of(context).translate('phone_no_validation');
    }
    return null;
  }

  String validateMsg(String message) {
    if (message.trim().length == 0) {
      return AppLocalizations.of(context).translate('msg_validation');
    }
    return null;
  }
}
