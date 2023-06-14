import 'dart:convert';

class Welcome {
    String email;
    String password;

    Welcome({
        required this.email,
        required this.password,
    });

    factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}

class Teacher {
    String registration;
    String name;
    String email;
    String password;
    List<Course> courses;

    Teacher({
        required this.registration,
        required this.name,
        required this.email,
        required this.password,
        required this.courses,
    });

    factory Teacher.fromRawJson(String str) => Teacher.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        registration: json["registration"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "registration": registration,
        "name": name,
        "email": email,
        "password": password,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    String id;
    String name;
    String period;
    String shift;

    Course({
        required this.id,
        required this.name,
        required this.period,
        required this.shift,
    });

    factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        period: json["period"],
        shift: json["shift"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "period": period,
        "shift": shift,
    };
}