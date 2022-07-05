class User {
  late final String UUID;
  late final String firstName;
  late final String lastName;

  // constructor
  User(this.UUID, this.firstName, this.lastName);

  // User methods
}

User login() {
  return User("345abc", "Tabby", "Tabs");
}
