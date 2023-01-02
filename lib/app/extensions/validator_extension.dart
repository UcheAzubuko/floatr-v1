import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  password() => add((value) {
        if (value!.length < 6) {
          return 'Your password should contain at least 6 characters';
        }
        return null;
      });

  fullname() => add((value) {
        if (value!.isEmpty) {
          return 'Please input ypur fullname';
        } else if (value.length < 6) {
          return 'Your fullname is too short';
        }
        return null;
      });

  bvn() => add((value) {
        if (value!.isEmpty) {
          return 'Please enter BVN';
        } else if (value.length < 11) {
          return 'Not a valid BVN';
        }
        return null;
      });
}
