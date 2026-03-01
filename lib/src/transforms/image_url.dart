/// Image URL Transformation
///
/// Transforms filename-only URLs to imgproxy URLs with processing options

const String defaultStorageUrl = 'https://cdn.chanomhub.com';

class ImgproxyOptions {
  final String? format;
  final String? resizeType;
  final int? width;
  final int? height;
  final int? quality;
  final String? gravity;
  final bool? enlarge;
  final int? dpr;
  final int? blur;
  final int? sharpen;

  const ImgproxyOptions({
    this.format = 'webp',
    this.resizeType,
    this.width,
    this.height,
    this.quality,
    this.gravity,
    this.enlarge,
    this.dpr,
    this.blur,
    this.sharpen,
  });
}

const ImgproxyOptions defaultImgproxyOptions = ImgproxyOptions();

/// Builds the imgproxy processing options path from ImgproxyOptions
String _buildImgproxyPath(ImgproxyOptions options) {
  final List<String> parts = [];

  // Resize: rs:%type:%width:%height:%enlarge
  if (options.resizeType != null ||
      options.width != null ||
      options.height != null ||
      options.enlarge != null) {
    final rs = [
      'rs',
      options.resizeType ?? 'fit',
      options.width ?? 0,
      options.height ?? 0,
      options.enlarge == true ? 1 : 0,
    ];
    parts.add(rs.join(':'));
  }

  // Quality: q:%quality
  if (options.quality != null && options.quality! > 0) {
    parts.add('q:${options.quality}');
  }

  // Gravity: g:%gravity
  if (options.gravity != null) {
    parts.add('g:${options.gravity}');
  }

  // DPR: dpr:%dpr
  if (options.dpr != null && options.dpr! > 1) {
    parts.add('dpr:${options.dpr}');
  }

  // Blur: bl:%sigma
  if (options.blur != null && options.blur! > 0) {
    parts.add('bl:${options.blur}');
  }

  // Sharpen: sh:%sigma
  if (options.sharpen != null && options.sharpen! > 0) {
    parts.add('sh:${options.sharpen}');
  }

  return parts.join('/');
}

/// Resolves an image URL using imgproxy format.
String? resolveImageUrl(
  String? imageUrl,
  String cdnUrl, {
  String storageUrl = defaultStorageUrl,
  ImgproxyOptions options = defaultImgproxyOptions,
}) {
  if (imageUrl == null || imageUrl.isEmpty) return null;

  // Already a full URL - return as-is
  if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
    return imageUrl;
  }

  // Build the source URL
  final sourceUrl = '$storageUrl/$imageUrl';

  // Build processing options path
  final optionsPath = _buildImgproxyPath(options);

  // Get format (default: webp)
  final format = options.format ?? 'webp';

  // Build imgproxy URL: /insecure/{options}/plain/{sourceUrl}@{format}
  final encodedSourceUrl = Uri.encodeComponent(sourceUrl);

  if (optionsPath.isNotEmpty) {
    return '$cdnUrl/insecure/$optionsPath/plain/$encodedSourceUrl@$format';
  }

  return '$cdnUrl/insecure/plain/$encodedSourceUrl@$format';
}

final Set<String> _imageFields = {
  'mainImage',
  'backgroundImage',
  'coverImage',
  'image',
};

/// Deep transforms all image URLs in an object/array recursively.
dynamic transformImageUrlsDeep(dynamic data, String cdnUrl) {
  if (data == null) return null;

  if (data is List) {
    return data.map((item) => transformImageUrlsDeep(item, cdnUrl)).toList();
  }

  if (data is Map<String, dynamic>) {
    final result = <String, dynamic>{};

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      // Transform known image URL fields
      if (_imageFields.contains(key) && value is String) {
        result[key] = resolveImageUrl(value, cdnUrl);
      }
      // Transform image objects with url property
      else if (key == 'images' && value is List) {
        result[key] =
            value.map((img) {
              if (img is Map<String, dynamic> &&
                  img.containsKey('url') &&
                  img['url'] is String) {
                return {
                  ...img,
                  'url': resolveImageUrl(img['url'] as String, cdnUrl),
                };
              }
              return img;
            }).toList();
      }
      // Recursively transform nested objects
      else if (value != null && (value is Map || value is List)) {
        result[key] = transformImageUrlsDeep(value, cdnUrl);
      } else {
        result[key] = value;
      }
    }

    return result;
  }

  return data;
}
