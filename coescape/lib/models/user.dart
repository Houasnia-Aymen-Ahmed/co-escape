class AppUser {
  String uid;
  String googleId;
  String username;
  String email;
  String photoURL;
  String? token;

  AppUser({
    this.uid = '',
    this.googleId = '',
    this.username = '',
    this.email = '',
    this.photoURL = '',
    this.token,
  });
}
