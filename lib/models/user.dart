class OurUser {
  String? uid;
  String? phone;
  String? displayName;
  String? country;
  String? avatarUrl;
  String? bio;
  String? lastActive;
  String? status;
  bool? isReadyForTxn;
  bool? isKycDone;
  String? userId;
  String? antpayPin;

  OurUser(
      {this.phone,
      this.uid,
      this.avatarUrl,
      this.country,
      this.displayName,
      this.bio,
      this.status,
      this.isReadyForTxn,
      this.isKycDone,
      this.lastActive,
      this.userId,
      this.antpayPin});

  /*factory OurUser.fromFireStore(DocumentSnapshot _data) {
    return OurUser(
      uid: _data["uid"],
      phone: _data["phoneNumber"] ?? "",
      displayName: _data["displayName"] ?? "",
      country: _data["country"] ?? "",
      avatarUrl: _data["avatarUrl"] ?? "",
      accountCreated: _data["accountCreated"],
      bio: _data["bio"] ?? "",
      lastActive: _data["lastActive"] ?? "",
    );
  }*/
}
