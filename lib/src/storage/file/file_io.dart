import 'dart:convert';
import 'dart:io';

import 'package:device_preview/src/state/state.dart';

import '../storage.dart';

/// A storage that saves device preview user preferences into
/// a single [file] as json content.
class FileDevicePreviewStorage extends DevicePreviewStorage {
  FileDevicePreviewStorage({
    required this.filePath,
  });

  /// The file to which the json content is saved to.
  final String filePath;

  /// Save the current preferences.
  @override
  Future<void> save(DevicePreviewData data) async {
    _saveData = data;
    _saveTask ??= _save();
    await _saveTask;
  }

  /// Load the last saved preferences.
  @override
  Future<DevicePreviewData?> load() async {
     final file =File(filePath);
      if (!await file.exists()) await file.create(recursive: true);
    final json = await file.readAsString();
    if (json.isEmpty) return null;
    return DevicePreviewData.fromJson(jsonDecode(json));
  }

  Future? _saveTask;

  DevicePreviewData? _saveData;

  Future _save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_saveData != null) {
      final file =File(filePath);
      if (!await file.exists()) await file.create(recursive: true);
      await file.writeAsString(jsonEncode(_saveData!.toJson()),);
    }
    _saveTask = null;
  }
}
