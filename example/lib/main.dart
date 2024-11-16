import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'basic.dart';
import 'custom_plugin.dart';

Future<void> main() async {
  final directory = await getApplicationSupportDirectory();
  runApp(DevicePreview(
    storage: FileDevicePreviewStorage(
      filePath: join(directory.path, 'device_preview.json'),
    ),
    enabled: true,
    tools: const [
      ...DevicePreview.defaultTools,
      CustomPlugin(),
    ],
    builder: (context) => const BasicApp(),
  ));
}
