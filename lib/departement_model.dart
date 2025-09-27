class Department {
  final String id;
  final String name;
  final String image;
  final String logo;
  final String title;
  final String content;

  Department({
    required this.id,
    required this.name,
    required this.image,
    required this.logo,
    required this.title,
    required this.content,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['_id'] as String,
      name: json['departmentName'] as String,
      image: json['departmentImage'] as String,
      logo: json['departmentLogo'] as String,
      title: json['departmentTitle'] as String,
      content: json['departmentContent'] as String,
    );
  }
}
