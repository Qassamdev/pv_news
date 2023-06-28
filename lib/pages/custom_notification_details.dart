import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wordpress_app/models/notification_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wordpress_app/services/app_service.dart';
import 'package:wordpress_app/utils/next_screen.dart';
import 'package:wordpress_app/widgets/full_image.dart';
import 'package:wordpress_app/widgets/local_video_player.dart';

class CustomNotificationDeatils extends StatelessWidget {
  const CustomNotificationDeatils({Key? key, required this.notificationModel})
      : super(key: key);

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    final String dateTime = Jiffy(notificationModel.date).fromNow();
    return Scaffold(
      appBar: AppBar(
        title: Text('notification details').tr(),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  AntDesign.clockcircleo,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Text(AppService.getNormalText(notificationModel.title!),
              style: TextStyle(
                  fontFamily: 'Manrope',
                  wordSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Html(
              data: notificationModel.body,
              onLinkTap: (String? url, RenderContext context1,
                  Map<String, String> attributes, _) {
                AppService().openLinkWithCustomTab(context, url!);
              },
              onImageTap: (String? url, RenderContext context1,
                  Map<String, String> attributes, _) {
                nextScreen(
                    context, FullScreenImage(imageUrl: url!, heroTag: url));
              },
              style: {
                "body": Style(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  fontSize: FontSize(16.0),
                  lineHeight: LineHeight(1.4),
                ),
                "figure":
                    Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
              },
              customRender: {
                "video": (RenderContext context1, Widget child) {
                  return LocalVideoPlayer(
                      videoUrl:
                          context1.tree.element!.attributes['src'].toString());
                },
              },
            ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
