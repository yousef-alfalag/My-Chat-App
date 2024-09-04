class Note {
  String userId;
  String title;
  String contact;
  String? color;

  Note(
      {required this.userId,
      required this.title,
      required this.contact,
      required this.color});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "name": title,
      "contact": contact,
      "color": color,
    };
  }
}
