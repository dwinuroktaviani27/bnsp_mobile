class AppUser {
  String? name;
  String? username;
  String? notelp;
  String? emailID;
  bool? hasCompleteProfile = false;
  String? uuid;

  AppUser();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'notelp': notelp,
      'emailID': emailID,
      'hasCompletedProfile': hasCompleteProfile,
      'uuid': uuid,
    };
  }

  AppUser.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    username = data['username'];
    notelp = data['notelp'];
    emailID = data['emailID'];
    hasCompleteProfile = data['hasCompleteProfile'];
    uuid = data['uuid'];
  }
}
