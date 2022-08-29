import 'package:flutter/cupertino.dart';
import 'package:Todo/services/local_notification_service.dart';

import '../models/note.dart';

class NotificationController extends ChangeNotifier {
  NotificationController() {
    service.initialize();
  }
  final LocalNotificationService service = LocalNotificationService();

  showNotification(Note note, int id) {
    service.showNotification(
      id: id,
      title: 'Todo',
      body: 'Task due time \n ${note.data}',
      date: note.dueDate,
    );
  }
}
