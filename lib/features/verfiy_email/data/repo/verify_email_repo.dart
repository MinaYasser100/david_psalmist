abstract class VerfiyEmailRepo {
  Future<bool> isEmailVerified();
  Future<void> resendVerificationEmail();
}
