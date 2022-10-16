enum ServiceStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  submitting,
  submissionSuccess,
  submissionFailure
}

enum LocationStatus {
  unknown,
  loaded
}

enum AuthenticationStatus {
  unknown,
  authenticating,
  authenticated,
  unAuthenticated
}
