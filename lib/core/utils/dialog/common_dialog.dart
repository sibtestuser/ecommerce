import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../error/error_response.dart';

class CommonDialog {
  CommonDialog();

  static Future<bool?> errorDialog(BuildContext context, ErrorResponse error) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 70,
            child: Column(
              children: [
                Text(
                  error.message ?? '',
                ),
                Text(error.code ?? '0000'),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
              onPressed: () {
                context.pop(true);
              },
              child: Text('다시 시도'),
            ),
            ElevatedButton(
              onPressed: () => exit(0),
              child: Text('종료'),
            ),
          ],
        );
      },
    );
  }
}
