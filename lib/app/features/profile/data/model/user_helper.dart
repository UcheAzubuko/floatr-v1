import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';

class UserHelper {
  final UserResponse _user;
  UserHelper({required UserResponse user}) : _user = user;

  bool isPersonalDetailsComplete() =>
      _user.gender!.name != null &&
      _user.maritalStatus!.name != null &&
      _user.stateOfOrigin!.name != null;

  bool isAddressComplete() =>
      _user.city != null &&
      _user.address != null &&
      _user.state!.name != null &&
      _user.country!.name != null;

  // bool isFullyInBoarded() => _user.is

  bool isEmployerDetailsComplete() => !(isNull(_user.employment) ||
      isNull(_user.employment!.employerName) ||
      isNull(_user.employment!.employerAddress));

  bool isNextOfKinComplete() => !(isNull(_user.nextOfKin) ||
      isNull(_user.nextOfKin!.address) ||
      isNull(_user.nextOfKin!.firstName));

  bool isIdDataComplete() =>
      (isNull(_user.idTypes) ? 0 : _user.idTypes!.length) > 0;

  bool isFullyOnboarded() =>
      isPersonalDetailsComplete() &&
      isIdDataComplete() &&
      isAddressComplete() &&
      isEmployerDetailsComplete() &&
      isNextOfKinComplete();

  isNull(dynamic object) => object == null;
}
