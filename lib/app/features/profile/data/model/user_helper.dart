import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';

class UserHelper {
  final UserResponse _user;
  UserHelper({required UserResponse user}) : _user = user;

  bool get isPersonalDetailsComplete => _isPersonalDetailsComplete();
  bool get isAddressComplete => _isAddressComplete();
  bool get isEmployerDetailsComplete => _isEmployerDetailsComplete();
  bool get isNextOfKinComplete => _isNextOfKinComplete();
  bool get isIdDataComplete => _isIdDataComplete();
  bool get isFullyOnboarded => _isFullyOnboarded();

  bool _isPersonalDetailsComplete() =>
      _user.gender!.name != null &&
      _user.maritalStatus!.name != null &&
      _user.stateOfOrigin!.name != null;

  bool _isAddressComplete() =>
      _user.city != null &&
      _user.address != null &&
      _user.state!.name != null &&
      _user.country!.name != null;

  // bool isFullyInBoarded() => _user.is

  bool _isEmployerDetailsComplete() => !(_isNull(_user.employment) ||
      _isNull(_user.employment!.employerName) ||
      _isNull(_user.employment!.employerAddress));

  bool _isNextOfKinComplete() => !(_isNull(_user.nextOfKin) ||
      _isNull(_user.nextOfKin!.address) ||
      _isNull(_user.nextOfKin!.firstName));

  bool _isIdDataComplete() =>
      (_isNull(_user.idTypes) ? 0 : _user.idTypes!.length) > 0;

  bool _isFullyOnboarded() =>
      _isPersonalDetailsComplete() &&
      _isIdDataComplete() &&
      _isAddressComplete() &&
      _isEmployerDetailsComplete() &&
      _isNextOfKinComplete();

  _isNull(dynamic object) => object == null;
}
