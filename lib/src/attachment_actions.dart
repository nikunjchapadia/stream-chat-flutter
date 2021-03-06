import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AttachmentActions extends StatelessWidget {
  final Attachment attachment;
  final Message message;

  const AttachmentActions({
    Key key,
    this.attachment,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streamChannel = StreamChannel.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: attachment.actions?.map((action) {
        if (action.style == 'primary') {
          return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('${action.text}'),
            color: action.style == 'primary'
                ? StreamChatTheme.of(context).accentColor
                : null,
            textColor: Colors.white,
            onPressed: () {
              streamChannel.channel.sendAction(message, {
                action.name: action.value,
              });
            },
          );
        }
        return OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('${action.text}'),
          color: StreamChatTheme.of(context).accentColor,
          onPressed: () {
            streamChannel.channel.sendAction(message, {
              action.name: action.value,
            });
          },
        );
      })?.toList(),
    );
  }
}
