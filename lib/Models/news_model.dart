// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class NewsModel {
  String newsImage = '';
  String information = '';
  String title = '';
  String newsId = '';
  String entryDate = '';
  String adminId = '';
  String status = '';

  NewsModel({
    required this.newsImage,
    required this.information,
    required this.title,
    required this.newsId,
    required this.entryDate,
    required this.adminId,
    required this.status,
  });

  NewsModel.fromJson(Map<String, dynamic> data) {
    newsImage = data['newsImage'] == null ? "unknown" : data['newsImage'];
    newsId = data['newsId'] == null ? "unknown" : data['newsId'];
    information = data['information'] == null ? "unknown" : data['information'];
    title = data['title'] == null ? "unknown" : data['title'];
    entryDate = data['entryDate'] == null ? "unknown" : data['entryDate'];
    status = data['status'] == null ? "unknown" : data['status'];
    adminId = data['adminId'] == null ? "unknown" : data['adminId'];
  }
}
