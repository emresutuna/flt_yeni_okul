enum UserRole{
  ADMIN("ADMIN"),
  STUDENT("Öğrenci"),
  TEACHER("Öğretmen"),
  COMPANY("Kurum"),
  DEFAULT("default");
  final String label; // define a private field

  const UserRole(this.label); // constructor

  static UserRole fromString(String label) { // static parser method
    return values.firstWhere(
          (v) => v.label == label,
      orElse: () => UserRole.DEFAULT,
    );
  }
}