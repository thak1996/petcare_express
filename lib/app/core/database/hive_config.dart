import 'package:hive_flutter/hive_flutter.dart';
import '../models/auth/user.model.dart';
import '../models/features/notification.model.dart';
import '../models/features/pet.model.dart';
import '../models/features/schedule.model.dart';

class HiveConfig {
  static const String petBoxName = 'pets_box';
  static const String scheduleBoxName = 'schedules_box';
  static const String notificationBoxName = 'notifications_box';
  static const String userBoxName = 'user_cache_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PetModelAdapter());
    Hive.registerAdapter(ScheduleModelAdapter());
    Hive.registerAdapter(TaskTypeAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(NotificationTypeAdapter());
    Hive.registerAdapter(UserModelAdapter());

    final petBox = await Hive.openBox<PetModel>(petBoxName);
    final scheduleBox = await Hive.openBox<ScheduleModel>(scheduleBoxName);
    final notifBox = await Hive.openBox<NotificationModel>(notificationBoxName);
    await Hive.openBox<UserModel>(userBoxName);

    if (petBox.isEmpty) {
      await _seedPetsAndTasks(petBox, scheduleBox);
    }
    if (notifBox.isEmpty) {
      await _seedNotifications(notifBox);
    }
  }

  static Future<void> _seedPetsAndTasks(
    Box<PetModel> petBox,
    Box<ScheduleModel> scheduleBox,
  ) async {
    final rex = PetModel(
      id: 'pet_1',
      name: 'Rex',
      imageUrl: 'https://placedog.net/200',
      colorValue: 0xFF2196F3,
    );
    final luna = PetModel(
      id: 'pet_2',
      name: 'Luna',
      imageUrl: 'https://placedog.net/201',
      colorValue: 0xFFFFC107,
    );

    await petBox.putAll({rex.id: rex, luna.id: luna});

    final now = DateTime.now();
    final tasks = [
      ScheduleModel(
        id: 't1',
        title: 'Vacina',
        time: '09:00',
        subtitle: 'Vet',
        type: TaskType.health,
        petId: rex.id,
        petName: rex.name,
        date: now,
      ),
      ScheduleModel(
        id: 't2',
        title: 'Passeio',
        time: '17:00',
        subtitle: 'Parque',
        type: TaskType.activity,
        petId: rex.id,
        petName: rex.name,
        date: now,
        isDone: true,
      ),
      ScheduleModel(
        id: 't3',
        title: 'Ração',
        time: '19:00',
        subtitle: 'Premium',
        type: TaskType.food,
        petId: rex.id,
        petName: rex.name,
        date: now,
      ),

      ScheduleModel(
        id: 't4',
        title: 'Banho',
        time: '14:00',
        subtitle: 'PetShop',
        type: TaskType.health,
        petId: luna.id,
        petName: luna.name,
        date: now,
      ),
      ScheduleModel(
        id: 't5',
        title: 'Sachê',
        time: '16:00',
        subtitle: 'Salmão',
        type: TaskType.food,
        petId: luna.id,
        petName: luna.name,
        date: now,
      ),
    ];

    for (var t in tasks) {
      await scheduleBox.put(t.id, t);
    }
  }

  static Future<void> _seedNotifications(Box<NotificationModel> box) async {
    final notifs = [
      NotificationModel(
        id: 'n1',
        title: 'Vacina Vencendo',
        body: 'A vacina do Rex vence amanhã!',
        type: NotificationType.warning,
      ),
      NotificationModel(
        id: 'n2',
        title: 'Promoção',
        body: '15% OFF hoje.',
        type: NotificationType.promo,
      ),
      NotificationModel(
        id: 'n3',
        title: 'Bem-vindo',
        body: 'Configure seu perfil.',
        type: NotificationType.info,
      ),
    ];
    for (var n in notifs) {
      await box.put(n.id, n);
    }
  }
}
