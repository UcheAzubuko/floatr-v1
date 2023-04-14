class APIConfigs {
  // base url
  // static const baseUrl = 'floatr-backend.herokuapp.com';
  static const baseUrl = 'api.floatr.ng';

  static const activities = 'v1/users/me/activities';
  static const verifyCard = 'v1/transaction/verify/monnify';
  static const banks = '/v1/banks';
  static const beginPhoneVerificationPath =
      '/v1/users/me/begin-phone-verification';
  static const countriesPath = '/v1/countries';
  static const employmentPath = 'v1/users/me/employment';
  static const gendersPath = '/v1/genders';
  static const filesUploadPath = '/v1/files/upload';
  static const forgotPassword = 'v1/users/forgot-password';
  static const loginPath = '/v1/auth/login';
  static const loans = '/v1/loans';
  static const userLoans = '/v1/users/me/loans';
  static userSubscribedLoan(String loanId) => '/v1/users/me/loans/application/$loanId';
  static userLoanBalance(String loanId) => '/v1/users/me/loans/application/$loanId/balance';
  static const maritalStatusPath = '/v1/marital-status';
  static const nextOfKinPath = '/v1/users/me/next-of-kin';
  static const passwordPath = '/v1/users/me/password';
  static const pinPath = '/v1/users/me/pin';
  static const registerPath = '/v1/auth/register';
  static const resetPassword = '/v1/users/reset-password';
  static const saveSelfiePath = '/v1/users/me/save-selfie';
  static const saveDocumentPath = '/v1/users/me/identity-document';
  static states(String code) => '/v1/country/$code/states';
  static const user = '/v1/users/me';
  static const userBanks = 'v1/users/me/banks';
  static userCards([String cardId = '']) => 'v1/users/me/cards/$cardId';
  static const userFullPath = 'https://$baseUrl/v1/users/me?mask=false';
  static const verifyAccount = '/v1/banks/verify-account';
  static const verifyBVNPath = '/v1/users/me/verify-bvn';
  static const verifyForgotPasswordToken =
      'v1/users/verify-forgot-password-token';
  static const verifyPhonePath = 'v1/users/me/verify-phone';
}

class StorageKeys {
  static const accessTokenKey = "__Access__Token__Key__";
  static const passKey = "__pass__key__";
  static const emailKey = "__email__key__";
  static const biometricStatusKey = "__biometricStatusKey";
}
