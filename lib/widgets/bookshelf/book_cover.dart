import 'dart:io';

import 'package:anx_reader/models/book.dart';
import 'package:flutter/material.dart';

Widget bookCover(
  BuildContext context,
  Book book, {
  double? height,
  double? width,
  double? radius,
}) {
  radius ??= 8;
  File file = File(book.coverFullPath);

  Widget defaultCover = Container(
    color: Colors.primaries[book.title.hashCode % Colors.primaries.length].shade200,
    child: Center(
      child: Icon(
        Icons.book,
        size: 40,
        color: Theme.of(context).hintColor,
      ),
    ),
  );

  Widget child;
  if (file.existsSync()) {
    child = Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // 文件存在但不是有效图片时，显示默认封面
        return defaultCover;
      },
    );
  } else {
    child = defaultCover;
  }

  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            width: 0.3,
            color: Colors.grey,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ));
}
