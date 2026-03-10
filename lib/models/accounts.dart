class Account {
  int? id;
  String accountType;
  String username;
  String password;

  Account({
    this.id,
    required this.accountType,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountType': accountType,
      'username': username,
      'password': password,
    };
  }
    factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      accountType: map['accountType'],
      username: map['username'],
      password: map['password'],
    );
  }
}