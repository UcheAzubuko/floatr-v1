import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class PictureUploadService {
  // convert image to webp
  static Future<File?> convertToWebp(File imageFile) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        '${imageFile.absolute.path}/temp.webp',
        minHeight: 1080,
        minWidth: 1080,
        quality: 96,
        rotate: 270,
        format: CompressFormat.webp,
      );
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  // init file upload

  //
}
