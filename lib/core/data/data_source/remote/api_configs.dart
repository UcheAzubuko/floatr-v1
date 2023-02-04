class APIConfigs {
  static const baseUrl = 'floatr-backend.herokuapp.com';
  static const banks = '/v1/banks';
  static const beginPhoneVerificationPath =
      '/v1/users/me/begin-phone-verification';
  static const countriesPath = '/v1/countries';
  static const employmentPath = 'v1/users/me/employment';
  static const gendersPath = '/v1/genders';
  static const loginPath = '/v1/auth/login';
  static const loans = '/v1/loans';
  static const maritalStatusPath = '/v1/marital-status';
  static const nextOfKinPath = '/v1/users/me/next-of-kin';
  static const registerPath = '/v1/auth/register';
  static const filesUploadPath = '/v1/files/upload';
  static const saveSelfiePath = '/v1/users/me/save-selfie';
  static const saveDocumentPath = '/v1/users/me/identity-document';
  static states(String code) => '/v1/country/$code/states';
  static const user = '/v1/users/me';
  static const userBanks = 'v1/users/me/banks';
  static const userFullPath =
      'https://floatr-backend.herokuapp.com/v1/users/me?mask=false';
  static const verifyPhonePath = 'v1/users/me/verify-phone';
  static const verifyAccount = '/v1/banks/verify-account';
  static const verifyBVNPath = '/v1/users/me/verify-bvn';
}

class StorageKeys {
  static const accessTokenKey = "__Access__Token__Key__";
}
