
class Patient {
  final int id;
  final String fullName;
  final String nationalId;
  final String bloodType;
  final int age;

  Patient({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.bloodType,
    required this.age,
  });

  // هذه الدالة تحول البيانات القادمة من الإنترنت (JSON) إلى كائن (Object) يفهمه التطبيق
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['full_name'],
      nationalId: json['national_id'],
      bloodType: json['blood_type'],
      age: json['age'],
    );
  }
}