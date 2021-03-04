class NotificationResponse {
  int totalNotification;
  List<Notification> notificationList = [];

  NotificationResponse({this.totalNotification, this.notificationList});
}

class Notification {
  String uniqueId, title, description;
  int dateTime;

  Notification({this.uniqueId, this.title, this.description, this.dateTime});
}
