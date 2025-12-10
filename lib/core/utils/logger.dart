import 'package:logger/logger.dart';

final Logger log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 10,
    lineLength: 50,
    colors: false,
    printEmojis: true,
  ),
);
