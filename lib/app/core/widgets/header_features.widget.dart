import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petcare_express/app/core/theme/app.colors.dart';
import '../models/features/notification.model.dart';

enum HeaderStyle { home, feature }

class HeaderFeaturesWidget extends StatelessWidget {
  const HeaderFeaturesWidget({
    super.key,
    required this.style,
    this.userName,
    this.title,
    this.subtitle,
    required this.notifications,
    this.margin,
    this.onDismissNotification,
  });

  final HeaderStyle style;
  final String? userName;
  final String? title;
  final String? subtitle;
  final List<NotificationModel> notifications;
  final EdgeInsetsGeometry? margin;
  final Function(NotificationModel)? onDismissNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: style == HeaderStyle.home
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildTextContent(context)),
          _buildNotificationButton(context),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    if (style == HeaderStyle.home) {
      // Estilo HOME: "Bom dia, Franklyn!"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bom dia,",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),
          ),
          Text(
            "${userName ?? 'Usuário'}!",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      );
    } else {
      // Estilo FEATURE: "AGENDA DE Outubro 2023"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (title ?? "").toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade400,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            subtitle ?? "",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      );
    }
  }

  // O seu método original de notificações (mantido)
  Widget _buildNotificationButton(BuildContext context) {
    return InkWell(
      onTap: () => _showNotificationsModal(context),
      borderRadius: BorderRadius.circular(30.r),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_rounded,
              size: 24.sp,
              color: Colors.black87,
            ),
          ),
          if (notifications.isNotEmpty)
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showNotificationsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setStateModal) => Container(
          height: 0.6.sh,
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notificações",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade300),
              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 40.sp,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Sem novas notificações",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: notifications.length,
                        separatorBuilder: (_, __) =>
                            Divider(color: Colors.grey.shade100),
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return Dismissible(
                            key: ValueKey(item.hashCode),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20.w),
                              color: Colors.red.shade100,
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 24.sp,
                              ),
                            ),
                            onDismissed: (direction) {
                              notifications.removeAt(index);
                              onDismissNotification?.call(item);
                              setStateModal(() {});
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: item.color.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item.icon,
                                  color: item.color,
                                  size: 20.sp,
                                ),
                              ),
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              subtitle: Text(
                                item.body,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
