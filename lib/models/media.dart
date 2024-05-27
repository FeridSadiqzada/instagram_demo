class Media {
  final String path;
  final String extension;
  final String mimeType;
  final String fileSize;
  final String width;
  final String height;

  Media({
    required this.path,
    required this.extension,
    required this.mimeType,
    required this.fileSize,
    required this.width,
    required this.height,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        path: json['path'],
        extension: json['extension'],
        mimeType: json['mime_type'],
        fileSize: json['file_size'],
        width: json['width'],
        height: json['height'],
      );
}