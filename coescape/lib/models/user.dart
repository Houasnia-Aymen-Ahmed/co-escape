class AppUser {
  String uid;
 String usertype; 
  String username;
  String email;
  String photoURL;
  String domain;
  String? googleId;
  String? token;

  AppUser({
    this.uid = '',
    this.usertype = '',
    this.username = '',
    this.email = '',
    this.photoURL = '',
    this.domain = '',
    this.googleId = '',
    this.token,
  });
}
