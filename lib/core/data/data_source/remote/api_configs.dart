class APIConfigs {
  static const baseUrl = 'floatr-backend.herokuapp.com';
  static const loginPath = '/v1/auth/login';
  static const registerPath = '/v1/auth/register';
  static const filesUploadPath = '/v1/files/upload';
  static const beginPhoneVerificationPath = '/v1/users/me/begin-phone-verification';
  static const saveSelfiePath = '/v1/users/me/save-selfie';
  static const verifyPhone = 'v1/users/me/verify-phone';
  static const verifyBVN = '/v1/users/me/verify-bvn';
}

class StorageKeys {
  static const accessTokenKey = "__Access__Token__Key__";
}
