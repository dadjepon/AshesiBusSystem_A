import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:flutter/material.dart';


class MessageDialogBox extends StatelessWidget {

  final String message;
  final String title;
  final Function () onOk;

  const MessageDialogBox(
    {
      super.key, 
      required this.message,
      required this.title,
      required this.onOk,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: HeaderText(
        text: title
      ),
      content: RegularText(
        text: message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onOk,
          child: RegularText(
            text: "OK",
          ),
        ),
      ],
    );
  }
}


class ConfirmDialogBox extends StatelessWidget {

  final String message;
  final String title;
  final Function () onOk;

  const ConfirmDialogBox(
    {
      super.key, 
      required this.message,
      required this.title,
      required this.onOk,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: HeaderText(
        text: title
      ),
      content: RegularText(
        text: message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onOk,
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}


class DialogBoxWithDropDown extends StatelessWidget {

  final String message;
  final String title;
  final Function () onOk;
  final List<String> items;
  final String? value;
  final String hintText;
  final Function(String?)? onChanged;

  const DialogBoxWithDropDown(
    {
      super.key, 
      required this.message,
      required this.title,
      required this.onOk,
      required this.items,
      required this.hintText,
      this.value,
      this.onChanged
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: HeaderText(
        text: title
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RegularText(
            text: message,
          ),
          AppDropDownButton(
            items: items,
            onChanged: onChanged,
            hintText: hintText,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onOk,
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}